#!/bin/bash
#
# Script sets to cron new task to backup the main MongoDB database
# (defined from role defaults or playbook --extra-vars).
#

set -e

date=$(date +%F)

if [ -z "$1" ]; then
  database="{{ mongo_backup_db }}"
else
  database=$1
fi

backup_dir="{{mongo_backup_path}}/${database}/${date}/"
mkdir -p "${backup_dir}"
cd "${backup_dir}"

mongodump --authenticationDatabase=admin \
  --username=backup --password="{{ passwd_mongo_backup }}" \
  --port=28000 --db="${database}" \
  --archive="${database}_$(date +%Y%m%d%H%M).gz" --gzip
echo "DB "${database}" was backed up to: "${backup_dir}""

# delete old archives, keep 30 newest
rm -f $(ls -t | awk 'NR>30')
echo -e "List of backups:\n$(ls -t)"
