#!/bin/bash
#
# This script adds some cron jobs:
#   - script that starts at 4.00am on Saturdays;
#   - script that starts at system startup;
#   - script that starts every 3 hours;
#   - script that starts every 10 seconds.
#

set -e

# check for root
if [[ "$(id -u)" != "0" ]];then
  echo "This script must be run as root" 1>&2
  exit 1
fi

cp -f cronjob* /etc/cron.d/
chmod 600 /etc/cron.d/cronjob*
