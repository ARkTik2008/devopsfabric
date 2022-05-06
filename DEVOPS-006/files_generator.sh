#!/bin/bash
#
# This script generates 1024 files with random content and filenames,
# size of each file is 20 KB.
# Usage: ./files_generator.sh

set -e

file_dir="files"

if ! [ -d "$file_dir" ]
  then mkdir "$file_dir"
fi

cd "$file_dir"
count=0
while [ $count -lt 1024 ]; do
  filename=$(cat "/dev/urandom" | tr -cd 'a-fA-Z0-9' \
    | head -c "$(shuf -i 10-30 -n 1)")
  head -c 20K "/dev/urandom" > "$filename"
  count=$(( "$count" + 1 ))
  echo -e "$count - $filename"
done
