#!/bin/bash
#
# This script sets some custom script as a service (deamonizes it).
#

set -e

# copying script
cp tail_passwd.sh /opt
chmod +x /opt/tail_passwd.sh

# copying service unit file
cp tail_passwd.service /etc/systemd/system

# enabling service unit and starting it
systemctl enable tail_passwd.service
systemctl start tail_passwd.service
