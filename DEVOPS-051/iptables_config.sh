#!/bin/bash
# Configuring iptables rules as as shown below:
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

# saving existing iptables rules
mkdir -p /etc/iptables-conf
iptables-save -f /etc/iptables-conf/iptables.backup.`date +%Y%m%d_%H-%M`

# reseting old iptables rules
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -Z

# allowing all ESTABLISHED
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# allowing ssh
iptables -A INPUT -s 192.168.88.0/24 -p TCP --dport 22 -j ACCEPT

# allowing 80/TCP incoming traffic
iptables -A INPUT -p TCP --dport 80 -j ACCEPT

# allowing ping
iptables -A INPUT -p ICMP --icmp-type echo-request -j ACCEPT
iptables -I OUTPUT -p ICMP -j ACCEPT

# allowing DNS 53/UDP
iptables -A INPUT -p UDP --dport 53 -j ACCEPT
iptables -A OUTPUT -p UDP --dport 53 -j ACCEPT

# allowing 80/TCP 443/TCP outgoing traffic
iptables -A OUTPUT -p TCP --dport 80 -j ACCEPT
iptables -A OUTPUT -p TCP --dport 443 -j ACCEPT

# setting the default policy to DROP
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP
