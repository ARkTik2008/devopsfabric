#!/bin/bash
# This script applies .sql file and allow external connections to MySQL server.
#

set -e

# check for root
if [[ "$(id -u)" != "0" ]];then
  echo "This script must be run as root" 1>&2
  exit 1
fi

mysql -u root < application_users.sql

iptables -A INPUT -p tcp --destination-port 3306 \
  -m iprange --src-range 10.10.0.177-10.10.0.190 -j ACCEPT

iptables -A INPUT -p tcp --destination-port 3306 \
  -m iprange --src-range 172.16.0.129-172.16.0.198 -j ACCEPT
