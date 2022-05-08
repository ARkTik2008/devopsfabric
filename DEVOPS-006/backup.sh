#!/bin/sh
#
# This script backups all files in the directory 'files' with tar and
# compress with gz. Only the most recent 5 archives are stored.
# Usage: ./backup.sh

set -e

backup_path="backup"
backup_dir="files"

if ! [ -d "$backup_path" ]
  then mkdir "$backup_path"
fi

tar -zcf "$backup_path"/"backup_$(date +%Y%m%d_%H-%M).tar.gz" $backup_dir
cd backup/
rm -f $(ls -t | awk 'NR>5')
