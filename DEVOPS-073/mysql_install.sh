#!/bin/bash
#
# This script silently installs the latest stable MySQL on Ubuntu
# (unattended installation)
#

set -e

# checking for root
if [[ "$(id -u)" != "0" ]];then
  echo "This script must be run as root" 1>&2
  exit 1
fi

# installing without prompts
export DEBIAN_FRONTEND="noninteractive"

# generating password
mysql_passwd=$(openssl rand -base64 14)

# setting password for the MySQL root user
debconf-set-selections <<< "mysql-server mysql-server/root_password password ${mysql_passwd}"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${mysql_passwd}"

cd /tmp
curl -OL https://dev.mysql.com/get/mysql-apt-config_0.8.22-1_all.deb
sudo -E dpkg -i mysql-apt-config*
apt update
rm -f mysql-apt-config*
sudo -E apt install -y mysql-server

# most secure options
mysql_secure_installation -u root --password="${mysql_passwd}" --use-default

# starting MySQL and enabling autostart
systemctl start mysql
systemctl enable mysql

mysqladmin --user=root --password="${mysql_passwd}" ping | tee /tmp/mysql.log

# printing password
echo -e "#########################################"
echo -e "MySQL password is: ${mysql_passwd}"
echo -e "#########################################"

echo "$mysql_passwd" >> /tmp/mysql.log
echo -e "Password is stored in /tmp/mysql.log"
