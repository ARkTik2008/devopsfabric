#!/bin/bash
# Configuring UFW (Uncomplicated FireWall) rules as shown below:
#  - DROP all traffic by default;
#  - ACCEPT IN 80/TCP;
#  - ACCEPT OUT 80/TCP, 443/TCP, 53/UDP;
#  - ACCEPT ESTABLISHED,RELATED;
#  - allow ssh from local network;
#  - allow ping.
#

set -e

# checking for root
if [[ "$(id -u)" != "0" ]];then
  echo "This script must be run as root" 1>&2
  exit 1
fi

# resetting old rules
ufw --force reset

# activating and enabling UFW on system startup
ufw --force enable

# allowing ssh
ufw allow from 192.168.88.0/24 to any port 22 proto tcp

# allowing 80/TCP incoming and outgoing traffic
ufw allow 80/tcp

# allowing 443/TCP outgoing traffic
ufw allow out 443/tcp

### allowing outgoing ICMP:
# 1. backuping /etc/ufw/before.rules
cp -f /etc/ufw/before.rules /etc/ufw/before.rules.bakup

# 2. adding 2 new rules to /etc/ufw/before.rules
if [[ -z $(cat /etc/ufw/before.rules | grep 'allow outbound icmp') ]]; then
  # temporary deleting closing 'COMMIT' command
  sed -i '/^COMMIT$/d' /etc/ufw/before.rules
  # adding new rules and return back closing 'COMMIT' command
  cat >> /etc/ufw/before.rules << EOF
#
# allow outbound icmp
-A ufw-before-output -p icmp -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
-A ufw-before-output -p icmp -m state --state ESTABLISHED,RELATED -j ACCEPT

COMMIT
EOF
  echo "New rules added to /etc/ufw/before.rules"
  else echo "Outgoing ICMP rules have been added previously"
fi

# incoming echo-requests are allowed by default
# ESTABLISHED connections are allowed by default
# all connections on loopback are allowed by default

# allowing DNS
ufw allow out 53/udp

# DROP all traffic by default
ufw default deny incoming
ufw default deny outgoing

# applying new rules
ufw reload
