#!/bin/bash
#
# Script sets to cron new task to backup all MongoDB database
#

set -e

date=$(date +%F)
backup_dir="{{mongo_backup_path}}/all_dbs/${date}/"

mkdir -p "${backup_dir}"
cd "${backup_dir}"

mongodump --authenticationDatabase=admin \
  --username=backup --password="{{ passwd_mongo_backup }}" \
  --port=28000 --archive="all_dbs_$(date +%Y%m%d%H%M).gz" --gzip
echo "All dbs were backed up to: "${backup_dir}""

# delete old archives, keep 14 newest
rm -f $(ls -t | awk 'NR>14')
echo -e "List of backups:\n$(ls -t)"
