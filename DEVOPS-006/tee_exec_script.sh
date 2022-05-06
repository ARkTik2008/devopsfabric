#!/bin/bash
#
# The script each 10 seconds shows STDOUT of a command from the first
# command line argument, simultaneously writes the same output to a file.
# Usage: ./tee_exec_script.sh <command>

set -e

if [ $# -eq 0 ]
then
  echo
  echo "The script each 10 seconds shows STDOUT of a command from the first"
  echo "command line argument, simultaneously writes the same output to a file."
  echo
  echo "Usage: ./tee_exec_script.sh <command>"
  echo "Examples:"
  echo "    ./tee_exec_script.sh 'ps auxww'"
  echo "    ./tee_exec_script.sh top"
  echo "    ./tee_exec_script.sh 'vmstat 5'"
  exit 1
fi

exec > >(tee -a output_"$$".txt)
clear
while true
do
  clear
  echo ">>>>>>>>" "$(date)" "<<<<<<<<"
  bash -c "$1"
  sleep 10
done

# Another way, but 'vmstat 5' breaks it
# exec > >(tee -a output_"$$".txt)
# watch -n10 -d -c -e "eval $1"
