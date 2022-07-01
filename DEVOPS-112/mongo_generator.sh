#!/bin/bash
#
# The Document Generator Utility for MongoDB.
# It generates 1000 random records ('documents') in 20 collections in 5 dbs.
#

set -e

# local vars
mongoUser="mongoUser"
read -s -p "Mongo Admin Password: " admin_pwd
echo
read -s -p "Mongo User Password: " mongoUser_pwd
echo

# Create one user and five dbs named stage_db{1..5}
mongosh --port 28000 admin -u admin -p "$admin_pwd" <<EOF
db.createUser({
  user: "$mongoUser",
  pwd: "$mongoUser_pwd",
  roles: [
    { role: "readWrite", db: "stage_db1"},
    { role: "readWrite", db: "stage_db2"},
    { role: "readWrite", db: "stage_db3"},
    { role: "readWrite", db: "stage_db4"},
    { role: "readWrite", db: "stage_db5"}
  ]})
exit
EOF

# Generate random records and insert them into dbs
# main loop for dbs starts
for ((i=1;i<6;i++)); do
  echo "Filling in with data, current database: stage_db${i}"
  # nested loop for collections starts
  for ((j=1;j<5;j++)); do
    echo "Filling in with data, current collection: collection${j}"
    collectionName="collection${j}"
    # standalone javascript loop in mongo shell command
    mongosh --port 28000 -u "$mongoUser" -p "$mongoUser_pwd" <<EOF
use stage_db${i}
for (var k = 1; k <= 1000; ++k) {
  var randomDate = (Date.now() - (Math.floor(Math.random() * 1000 * 60 * 60 * 24)));
  var randomName = (Math.random()+1).toString(36).substring(2);
  db.$collectionName.insertOne({
  name: randomName,
  creationDate: randomDate,
  uid: k
}); }
show dbs
show collections
db.$collectionName.countDocuments()
exit
EOF
  # nested loop for collections ends
  done

# Validation
  echo "===================================================================="
  echo "Validate Document Generator Utility with random samples of documents"
  echo "from random collection from database stage_db${i}"
  echo "===================================================================="
  mongosh --port 28000 -u "$mongoUser" -p "$mongoUser_pwd" <<EOF
use stage_db${i}
db.collection$((1 + $RANDOM % 4)).aggregate([{\$sample: {size: 2}}]);
EOF
# main loop for dbs ends
done
