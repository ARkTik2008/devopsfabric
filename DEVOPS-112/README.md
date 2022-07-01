# DEVOPS-112 mongodb data generation

The Document Generator Utility for MongoDB, generates 1000 random records ('documents') in 20 collections in 5 dbs.  
Script: [./mongo_generator.sh](/DEVOPS-112/mongo_generator.sh)

## Script run output

**(validation and testing included)**  

`./mongo_generator.sh`

```yaml
Mongo Admin Password:
Mongo User Password: 
Current Mongosh Log ID:    62be16434f6ae6f3152439ee
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/admin?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

admin> db.createUser({
...   user: "mongoUser",
...   pwd: "NjVkNTcyZDdlM2U4MzE4",
...   roles: [
...     { role: "readWrite", db: "stage_db1"},
...     { role: "readWrite", db: "stage_db2"},
...     { role: "readWrite", db: "stage_db3"},
...     { role: "readWrite", db: "stage_db4"},
...     { role: "readWrite", db: "stage_db5"}
...   ]})
{ ok: 1 }
admin> exit
Filling in with data, current database: stage_db1
Filling in with data, current collection: collection1
Current Mongosh Log ID: 62be1647ef5da5ea82245a93
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db1
switched to db stage_db1
stage_db1> for (var k = 1; k <= 1000; ++k) {
...   var randomDate = (Date.now() - (Math.floor(Math.random() * 1000 * 60 * 60 * 24)));
...   var randomName = (Math.random()+1).toString(36).substring(2);
...   db.collection1.insertOne({
.....   name: randomName,
.....   creationDate: randomDate,
.....   uid: k
..... }); }
{
  acknowledged: true,
  insertedId: ObjectId("62be1648c87ea7eba5637d9a")
}
stage_db1> show dbs
stage_db1  8.00 KiB
stage_db1> show collections
collection1
stage_db1> db.collection1.countDocuments()
1000
stage_db1> exit
Filling in with data, current collection: collection2
Current Mongosh Log ID: 62be164be483f54ea3e0f7ef
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db1
switched to db stage_db1
stage_db1> for (var k = 1; k <= 1000; ++k) {
...   var randomDate = (Date.now() - (Math.floor(Math.random() * 1000 * 60 * 60 * 24)));
...   var randomName = (Math.random()+1).toString(36).substring(2);
...   db.collection2.insertOne({
.....   name: randomName,
.....   creationDate: randomDate,
.....   uid: k
..... }); }
{
  acknowledged: true,
  insertedId: ObjectId("62be164c450a77938c70e3ee")
}
stage_db1> show dbs
stage_db1  16.00 KiB
stage_db1> show collections
collection1
collection2
stage_db1> db.collection2.countDocuments()
1000
stage_db1> exit
Filling in with data, current collection: collection3
Current Mongosh Log ID: 62be164eab213790aef301dc
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db1
switched to db stage_db1
stage_db1> for (var k = 1; k <= 1000; ++k) {
...   var randomDate = (Date.now() - (Math.floor(Math.random() * 1000 * 60 * 60 * 24)));
...   var randomName = (Math.random()+1).toString(36).substring(2);
...   db.collection3.insertOne({
.....   name: randomName,
.....   creationDate: randomDate,
.....   uid: k
..... }); }
{
  acknowledged: true,
  insertedId: ObjectId("62be164f49a4bcac5eaaa6fa")
}
stage_db1> show dbs
stage_db1  24.00 KiB
stage_db1> show collections
collection1
collection2
collection3
stage_db1> db.collection3.countDocuments()
1000
stage_db1> exit
Filling in with data, current collection: collection4
Current Mongosh Log ID: 62be165028349672ba0dce89
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db1
switched to db stage_db1
stage_db1> for (var k = 1; k <= 1000; ++k) {
...   var randomDate = (Date.now() - (Math.floor(Math.random() * 1000 * 60 * 60 * 24)));
...   var randomName = (Math.random()+1).toString(36).substring(2);
...   db.collection4.insertOne({
.....   name: randomName,
.....   creationDate: randomDate,
.....   uid: k
..... }); }
{
  acknowledged: true,
  insertedId: ObjectId("62be1651a8d5bda432133e93")
}
stage_db1> show dbs
stage_db1  32.00 KiB
stage_db1> show collections
collection1
collection2
collection3
collection4
stage_db1> db.collection4.countDocuments()
1000
stage_db1> exit
====================================================================
Validate Document Generator Utility with random samples of documents
from random collection from database stage_db1
====================================================================
Current Mongosh Log ID: 62be16533ef93fcbedd292a8
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db1
switched to db stage_db1
stage_db1> db.collection4.aggregate([{$sample: {size: 2}}]);
[
  {
    _id: ObjectId("62be1651a8d5bda432133ce6"),
    name: '9omfv7o543',
    creationDate: 1656615657110,
    uid: 571
  },
  {
    _id: ObjectId("62be1651a8d5bda432133acd"),
    name: 'sujjwspqvp',
    creationDate: 1656570926914,
    uid: 34
  }
]
stage_db1> Filling in with data, current database: stage_db2
Filling in with data, current collection: collection1
Current Mongosh Log ID: 62be1656a1bf12db780554a5
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db2
switched to db stage_db2
stage_db2> for (var k = 1; k <= 1000; ++k) {
...   var randomDate = (Date.now() - (Math.floor(Math.random() * 1000 * 60 * 60 * 24)));
...   var randomName = (Math.random()+1).toString(36).substring(2);
...   db.collection1.insertOne({
.....   name: randomName,
.....   creationDate: randomDate,
.....   uid: k
..... }); }
{
  acknowledged: true,
  insertedId: ObjectId("62be1657dc787b538a02c045")
}
stage_db2> show dbs
stage_db1  32.00 KiB
stage_db2   8.00 KiB
stage_db2> show collections
collection1
stage_db2> db.collection1.countDocuments()
1000
stage_db2> exit
Filling in with data, current collection: collection2
Current Mongosh Log ID: 62be1659ba6f81b3688421d2
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db2
switched to db stage_db2
stage_db2> for (var k = 1; k <= 1000; ++k) {
...   var randomDate = (Date.now() - (Math.floor(Math.random() * 1000 * 60 * 60 * 24)));
...   var randomName = (Math.random()+1).toString(36).substring(2);
...   db.collection2.insertOne({
.....   name: randomName,
.....   creationDate: randomDate,
.....   uid: k
..... }); }
{
  acknowledged: true,
  insertedId: ObjectId("62be165a36b4708a9d99abf2")
}
stage_db2> show dbs
stage_db1  32.00 KiB
stage_db2  16.00 KiB
stage_db2> show collections
collection1
collection2
stage_db2> db.collection2.countDocuments()
1000
stage_db2> exit
Filling in with data, current collection: collection3
Current Mongosh Log ID: 62be165c10f3b3d889f458d9
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db2
switched to db stage_db2
stage_db2> for (var k = 1; k <= 1000; ++k) {
...   var randomDate = (Date.now() - (Math.floor(Math.random() * 1000 * 60 * 60 * 24)));
...   var randomName = (Math.random()+1).toString(36).substring(2);
...   db.collection3.insertOne({
.....   name: randomName,
.....   creationDate: randomDate,
.....   uid: k
..... }); }
{
  acknowledged: true,
  insertedId: ObjectId("62be165d9f524a0c17c75d16")
}
stage_db2> show dbs
stage_db1  32.00 KiB
stage_db2  24.00 KiB
stage_db2> show collections
collection1
collection2
collection3
stage_db2> db.collection3.countDocuments()
1000
stage_db2> exit
Filling in with data, current collection: collection4
Current Mongosh Log ID: 62be166121928ee953700d7f
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db2
switched to db stage_db2
stage_db2> for (var k = 1; k <= 1000; ++k) {
...   var randomDate = (Date.now() - (Math.floor(Math.random() * 1000 * 60 * 60 * 24)));
...   var randomName = (Math.random()+1).toString(36).substring(2);
...   db.collection4.insertOne({
.....   name: randomName,
.....   creationDate: randomDate,
.....   uid: k
..... }); }
{
  acknowledged: true,
  insertedId: ObjectId("62be1663963da845ca2ab0e5")
}
stage_db2> show dbs
stage_db1  32.00 KiB
stage_db2  32.00 KiB
stage_db2> show collections
collection1
collection2
collection3
collection4
stage_db2> db.collection4.countDocuments()
1000
stage_db2> exit
====================================================================
Validate Document Generator Utility with random samples of documents
from random collection from database stage_db2
====================================================================
Current Mongosh Log ID: 62be1664df9e70148dc2cbbd
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db2
switched to db stage_db2
stage_db2> db.collection4.aggregate([{$sample: {size: 2}}]);
[
  {
    _id: ObjectId("62be1662963da845ca2aaf32"),
    name: 'zenm7z1uy',
    creationDate: 1656574920550,
    uid: 565
  },
  {
    _id: ObjectId("62be1663963da845ca2ab052"),
    name: '2zwiempfhl',
    creationDate: 1656604725768,
    uid: 853
  }
]
stage_db2> Filling in with data, current database: stage_db3
Filling in with data, current collection: collection1
Current Mongosh Log ID: 62be16663dcccdb34e45f59a
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db3
switched to db stage_db3
stage_db3> for (var k = 1; k <= 1000; ++k) {
...   var randomDate = (Date.now() - (Math.floor(Math.random() * 1000 * 60 * 60 * 24)));
...   var randomName = (Math.random()+1).toString(36).substring(2);
...   db.collection1.insertOne({
.....   name: randomName,
.....   creationDate: randomDate,
.....   uid: k
..... }); }
{
  acknowledged: true,
  insertedId: ObjectId("62be1667e1dc9876eec418a1")
}
stage_db3> show dbs
stage_db1  32.00 KiB
stage_db2  32.00 KiB
stage_db3   8.00 KiB
stage_db3> show collections
collection1
stage_db3> db.collection1.countDocuments()
1000
stage_db3> exit
Filling in with data, current collection: collection2
Current Mongosh Log ID: 62be1669aa4a957247c8b9d7
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db3
switched to db stage_db3
stage_db3> for (var k = 1; k <= 1000; ++k) {
...   var randomDate = (Date.now() - (Math.floor(Math.random() * 1000 * 60 * 60 * 24)));
...   var randomName = (Math.random()+1).toString(36).substring(2);
...   db.collection2.insertOne({
.....   name: randomName,
.....   creationDate: randomDate,
.....   uid: k
..... }); }
{
  acknowledged: true,
  insertedId: ObjectId("62be166a284d3290cc4c7987")
}
stage_db3> show dbs
stage_db1  32.00 KiB
stage_db2  32.00 KiB
stage_db3  16.00 KiB
stage_db3> show collections
collection1
collection2
stage_db3> db.collection2.countDocuments()
1000
stage_db3> exit
Filling in with data, current collection: collection3
Current Mongosh Log ID: 62be166c7e8fc0ec989e1307
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db3
switched to db stage_db3
stage_db3> for (var k = 1; k <= 1000; ++k) {
...   var randomDate = (Date.now() - (Math.floor(Math.random() * 1000 * 60 * 60 * 24)));
...   var randomName = (Math.random()+1).toString(36).substring(2);
...   db.collection3.insertOne({
.....   name: randomName,
.....   creationDate: randomDate,
.....   uid: k
..... }); }
{
  acknowledged: true,
  insertedId: ObjectId("62be166de3d85a2edd332a15")
}
stage_db3> show dbs
stage_db1  316.00 KiB
stage_db2  316.00 KiB
stage_db3  164.00 KiB
stage_db3> show collections
collection1
collection2
collection3
stage_db3> db.collection3.countDocuments()
1000
stage_db3> exit
Filling in with data, current collection: collection4
Current Mongosh Log ID: 62be16700664db9d3317b977
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db3
switched to db stage_db3
stage_db3> for (var k = 1; k <= 1000; ++k) {
...   var randomDate = (Date.now() - (Math.floor(Math.random() * 1000 * 60 * 60 * 24)));
...   var randomName = (Math.random()+1).toString(36).substring(2);
...   db.collection4.insertOne({
.....   name: randomName,
.....   creationDate: randomDate,
.....   uid: k
..... }); }
{
  acknowledged: true,
  insertedId: ObjectId("62be1671be9704b4ea5df4a6")
}
stage_db3> show dbs
stage_db1  316.00 KiB
stage_db2  316.00 KiB
stage_db3  172.00 KiB
stage_db3> show collections
collection1
collection2
collection3
collection4
stage_db3> db.collection4.countDocuments()
1000
stage_db3> exit
====================================================================
Validate Document Generator Utility with random samples of documents
from random collection from database stage_db3
====================================================================
Current Mongosh Log ID: 62be16732f75bda4304d9bd0
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db3
switched to db stage_db3
stage_db3> db.collection3.aggregate([{$sample: {size: 2}}]);
[
  {
    _id: ObjectId("62be166de3d85a2edd3327dc"),
    name: 'f2r7em51',
    creationDate: 1656570350859,
    uid: 431
  },
  {
    _id: ObjectId("62be166de3d85a2edd3329c2"),
    name: 'xut0exg2lc',
    creationDate: 1656574003904,
    uid: 917
  }
]
stage_db3> Filling in with data, current database: stage_db4
Filling in with data, current collection: collection1
Current Mongosh Log ID: 62be1675e4e4c37d90974f7e
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db4
switched to db stage_db4
stage_db4> for (var k = 1; k <= 1000; ++k) {
...   var randomDate = (Date.now() - (Math.floor(Math.random() * 1000 * 60 * 60 * 24)));
...   var randomName = (Math.random()+1).toString(36).substring(2);
...   db.collection1.insertOne({
.....   name: randomName,
.....   creationDate: randomDate,
.....   uid: k
..... }); }
{
  acknowledged: true,
  insertedId: ObjectId("62be167662cfd863f6e93e4f")
}
stage_db4> show dbs
stage_db1  316.00 KiB
stage_db2  316.00 KiB
stage_db3  172.00 KiB
stage_db4    8.00 KiB
stage_db4> show collections
collection1
stage_db4> db.collection1.countDocuments()
1000
stage_db4> exit
Filling in with data, current collection: collection2
Current Mongosh Log ID: 62be16798a6652822e777e06
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db4
switched to db stage_db4
stage_db4> for (var k = 1; k <= 1000; ++k) {
...   var randomDate = (Date.now() - (Math.floor(Math.random() * 1000 * 60 * 60 * 24)));
...   var randomName = (Math.random()+1).toString(36).substring(2);
...   db.collection2.insertOne({
.....   name: randomName,
.....   creationDate: randomDate,
.....   uid: k
..... }); }
{
  acknowledged: true,
  insertedId: ObjectId("62be167a50fb6b8f35fe8881")
}
stage_db4> show dbs
stage_db1  316.00 KiB
stage_db2  316.00 KiB
stage_db3  172.00 KiB
stage_db4   16.00 KiB
stage_db4> show collections
collection1
collection2
stage_db4> db.collection2.countDocuments()
1000
stage_db4> exit
Filling in with data, current collection: collection3
Current Mongosh Log ID: 62be167c5e85d8418c51440b
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db4
switched to db stage_db4
stage_db4> for (var k = 1; k <= 1000; ++k) {
...   var randomDate = (Date.now() - (Math.floor(Math.random() * 1000 * 60 * 60 * 24)));
...   var randomName = (Math.random()+1).toString(36).substring(2);
...   db.collection3.insertOne({
.....   name: randomName,
.....   creationDate: randomDate,
.....   uid: k
..... }); }
{
  acknowledged: true,
  insertedId: ObjectId("62be167ddbfdab4231500f3e")
}
stage_db4> show dbs
stage_db1  316.00 KiB
stage_db2  316.00 KiB
stage_db3  172.00 KiB
stage_db4   24.00 KiB
stage_db4> show collections
collection1
collection2
collection3
stage_db4> db.collection3.countDocuments()
1000
stage_db4> exit
Filling in with data, current collection: collection4
Current Mongosh Log ID: 62be167f1eaffb4f6d7cf176
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db4
switched to db stage_db4
stage_db4> for (var k = 1; k <= 1000; ++k) {
...   var randomDate = (Date.now() - (Math.floor(Math.random() * 1000 * 60 * 60 * 24)));
...   var randomName = (Math.random()+1).toString(36).substring(2);
...   db.collection4.insertOne({
.....   name: randomName,
.....   creationDate: randomDate,
.....   uid: k
..... }); }
{
  acknowledged: true,
  insertedId: ObjectId("62be16801f5c1f90867c759b")
}
stage_db4> show dbs
stage_db1  316.00 KiB
stage_db2  316.00 KiB
stage_db3  172.00 KiB
stage_db4   32.00 KiB
stage_db4> show collections
collection1
collection2
collection3
collection4
stage_db4> db.collection4.countDocuments()
1000
stage_db4> exit
====================================================================
Validate Document Generator Utility with random samples of documents
from random collection from database stage_db4
====================================================================
Current Mongosh Log ID: 62be168185d8699a4871884c
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db4
switched to db stage_db4
stage_db4> db.collection2.aggregate([{$sample: {size: 2}}]);
[
  {
    _id: ObjectId("62be167a50fb6b8f35fe877d"),
    name: 'm64i1d55qz',
    creationDate: 1656599128912,
    uid: 740
  },
  {
    _id: ObjectId("62be167a50fb6b8f35fe85bb"),
    name: 'ck9zl4moc9',
    creationDate: 1656590198475,
    uid: 290
  }
]
stage_db4> Filling in with data, current database: stage_db5
Filling in with data, current collection: collection1
Current Mongosh Log ID: 62be16837497357c93a22715
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db5
switched to db stage_db5
stage_db5> for (var k = 1; k <= 1000; ++k) {
...   var randomDate = (Date.now() - (Math.floor(Math.random() * 1000 * 60 * 60 * 24)));
...   var randomName = (Math.random()+1).toString(36).substring(2);
...   db.collection1.insertOne({
.....   name: randomName,
.....   creationDate: randomDate,
.....   uid: k
..... }); }
{
  acknowledged: true,
  insertedId: ObjectId("62be168573acf6107ba24a04")
}
stage_db5> show dbs
stage_db1  316.00 KiB
stage_db2  316.00 KiB
stage_db3  172.00 KiB
stage_db4   32.00 KiB
stage_db5    8.00 KiB
stage_db5> show collections
collection1
stage_db5> db.collection1.countDocuments()
1000
stage_db5> exit
Filling in with data, current collection: collection2
Current Mongosh Log ID: 62be16864cdec80b817b077c
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db5
switched to db stage_db5
stage_db5> for (var k = 1; k <= 1000; ++k) {
...   var randomDate = (Date.now() - (Math.floor(Math.random() * 1000 * 60 * 60 * 24)));
...   var randomName = (Math.random()+1).toString(36).substring(2);
...   db.collection2.insertOne({
.....   name: randomName,
.....   creationDate: randomDate,
.....   uid: k
..... }); }
{
  acknowledged: true,
  insertedId: ObjectId("62be1687951662febbd4b58a")
}
stage_db5> show dbs
stage_db1  316.00 KiB
stage_db2  316.00 KiB
stage_db3  172.00 KiB
stage_db4   32.00 KiB
stage_db5   16.00 KiB
stage_db5> show collections
collection1
collection2
stage_db5> db.collection2.countDocuments()
1000
stage_db5> exit
Filling in with data, current collection: collection3
Current Mongosh Log ID: 62be16892104ae344f52674f
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db5
switched to db stage_db5
stage_db5> for (var k = 1; k <= 1000; ++k) {
...   var randomDate = (Date.now() - (Math.floor(Math.random() * 1000 * 60 * 60 * 24)));
...   var randomName = (Math.random()+1).toString(36).substring(2);
...   db.collection3.insertOne({
.....   name: randomName,
.....   creationDate: randomDate,
.....   uid: k
..... }); }
{
  acknowledged: true,
  insertedId: ObjectId("62be168ac22a97620b8ac390")
}
stage_db5> show dbs
stage_db1  316.00 KiB
stage_db2  316.00 KiB
stage_db3  172.00 KiB
stage_db4   32.00 KiB
stage_db5   24.00 KiB
stage_db5> show collections
collection1
collection2
collection3
stage_db5> db.collection3.countDocuments()
1000
stage_db5> exit
Filling in with data, current collection: collection4
Current Mongosh Log ID: 62be168c00cee147377ec627
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db5
switched to db stage_db5
stage_db5> for (var k = 1; k <= 1000; ++k) {
...   var randomDate = (Date.now() - (Math.floor(Math.random() * 1000 * 60 * 60 * 24)));
...   var randomName = (Math.random()+1).toString(36).substring(2);
...   db.collection4.insertOne({
.....   name: randomName,
.....   creationDate: randomDate,
.....   uid: k
..... }); }
{
  acknowledged: true,
  insertedId: ObjectId("62be168d0f8fbdd938f3565f")
}
stage_db5> show dbs
stage_db1  316.00 KiB
stage_db2  316.00 KiB
stage_db3  172.00 KiB
stage_db4   32.00 KiB
stage_db5   32.00 KiB
stage_db5> show collections
collection1
collection2
collection3
collection4
stage_db5> db.collection4.countDocuments()
1000
stage_db5> exit
====================================================================
Validate Document Generator Utility with random samples of documents
from random collection from database stage_db5
====================================================================
Current Mongosh Log ID: 62be1690e2b540bb47094fcd
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use stage_db5
switched to db stage_db5
stage_db5> db.collection4.aggregate([{$sample: {size: 2}}]);
[
  {
    _id: ObjectId("62be168d0f8fbdd938f35480"),
    name: '0bp0my8pn5',
    creationDate: 1656549484316,
    uid: 521
  },
  {
    _id: ObjectId("62be168d0f8fbdd938f35333"),
    name: 'sgomchkge3',
    creationDate: 1656577484884,
    uid: 188
  }
]
stage_db5> 
```
