#!/bin/bash
#
# A script for user's custom login shell.

set -e
echo "1) ps auxww  3) who"
echo "2) dmesg"
echo "Please enter your choice: "

while :
  do
  read -r user_input
  case "$user_input" in
    1)
      ps auxww
      exit
      ;;
    2)
      dmesg
      exit
      ;;
    3)
      who
      exit
      ;;
    *)
      echo "Usage: enter the command number, one digit only."
      echo "1) ps auxww 2) dmesg 3) who"
      continue
      ;;
  esac
done
