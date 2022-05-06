#!/bin/sh
#
# This script backups all files in the directory 'files' with tar and
# compress with gz. Only the most recent 5 archives are stored.
# Usage: ./files_generator.sh

set -e

backup_path="backup/$(date +%Y%m%d)"
backup_dir="files"
mkdir -p "$backup_path"
tar -zcf "$backup_path"/"backup.tar.gz" $backup_dir
cd backup/
rm -rf $(ls -t | awk 'NR>5')
exit 0
