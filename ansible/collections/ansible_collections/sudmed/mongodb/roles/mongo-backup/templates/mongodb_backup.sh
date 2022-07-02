#!/bin/bash
#
# Script to backup the MongoDB databases all at once or separately
# (defined in role defaults or from ansible-playbook --extra-vars).
#

set -e
date=$(date +%F)
backup_dir="{{mongo_backup_path}}/${date}/"
del_date=$(date +%F --date="{{backup_retain_days}} days ago")

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "The backup script for MongoDB"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

mkdir -p "${backup_dir}"
cd "${backup_dir}"

if [[ "{{ mongo_backup_db }}" = "ALL" ]]; then
  echo "Starting backup for all databases"
  mongodump \
    --host="{{ mongo_host }}" \
    --port="{{ mongo_port }}" \
    --authenticationDatabase=admin \
    --username=backup \
    --password="{{ passwd_mongo_backup }}" \
    --gzip \
    --out="${backup_dir}"
else
  echo "Starting backup for databases: "{{ mongo_backup_db }}""
  dbs="{{ mongo_backup_db }}"
  for db in ${dbs}; do
    mongodump \
      --host="{{ mongo_host }}" \
      --port="{{ mongo_port }}" \
      --authenticationDatabase=admin \
      --username=backup \
      --password="{{ passwd_mongo_backup }}" \
      --db="${db}" \
      --gzip \
      --archive="${db}".gz
    echo "DB "${db}" was successfully archived in: "${backup_dir}""
  done
fi

# delete old archive
cd "{{mongo_backup_path}}"
  if [ ! -z ${del_date} ] && [ -d ${del_date} ]; then
    rm -rf ${del_date}
  fi

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "The script was executed successfully."
echo "List of backups: "
echo "----------------------------------------------------------------"
echo "$(tree "${backup_dir}" | cat)"
