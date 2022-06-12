#!/bin/bash
#
# This script silently installs the latest stable PostgreSQL on Ubuntu,
# adds DB and user, configures iptables.
#

set -e

# Create file repository configuration
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" \
  > /etc/apt/sources.list.d/pgdg.list'

# Import repository signing key
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc \
  | sudo apt-key add -

# Update package lists
sudo apt-get update

# Install the latest version of PostgreSQL
sudo apt-get -y install postgresql

# Generate passwords
psql_passwd1=$(openssl rand -base64 14) # app
psql_passwd2=$(openssl rand -base64 14) # app_debug
psql_passwd3=$(openssl rand -base64 14) # app_backup
psql_passwd4=$(openssl rand -base64 14) # dmitriy

# Create DB
sudo -i -u postgres psql -c "CREATE DATABASE application;"

# Create DB users
sudo -i -u postgres psql -c "CREATE USER app WITH password '$psql_passwd1';"
sudo -i -u postgres psql -c "CREATE USER app_debug WITH password '$psql_passwd2';"
sudo -i -u postgres psql -c "CREATE USER app_backup WITH password '$psql_passwd3';"
sudo -i -u postgres psql -c "CREATE USER dmitriy WITH password '$psql_passwd4';"

# Grant privileges
sudo -i -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE application TO app;"
sudo -i -u postgres psql -c "GRANT pg_read_all_data TO app_debug;"
sudo -i -u postgres psql -c "GRANT pg_read_all_data TO app_backup;"
sudo -i -u postgres psql -c "ALTER USER dmitriy WITH SUPERUSER;"


# Change listen address in postgresql.conf
sudo sed -i "s|#listen_addresses = 'localhost'|listen_addresses = '*'|" \
  /etc/postgresql/*/main/postgresql.conf

# Modify pg_hba.conf to dellete default 'host all' records
sudo sed -i '/host    all/d' /etc/postgresql/*/main/pg_hba.conf

# Modify pg_hba.conf to add trusted client subnets
echo "host    all             dmitriy         192.168.88.111/32       scram-sha-256" \
  | sudo tee -a /etc/postgresql/*/main/pg_hba.conf
echo "host    all             dmitriy         localhost               scram-sha-256" \
  | sudo tee -a /etc/postgresql/*/main/pg_hba.conf
echo "host    application     app             192.168.0.192/27        scram-sha-256" \
  | sudo tee -a /etc/postgresql/*/main/pg_hba.conf
echo "host    application     app_debug       172.16.0.0/25           scram-sha-256" \
  | sudo tee -a /etc/postgresql/*/main/pg_hba.conf
echo "host    application     app_debug       172.16.0.128/27         scram-sha-256" \
  | sudo tee -a /etc/postgresql/*/main/pg_hba.conf
echo "host    application     app_backup      127.0.0.1/32            scram-sha-256" \
  | sudo tee -a /etc/postgresql/*/main/pg_hba.conf
echo "host    application     app_backup      localhost               scram-sha-256" \
  | sudo tee -a /etc/postgresql/*/main/pg_hba.conf

# Restart postgresql
sudo systemctl restart postgresql
sudo systemctl status postgresql

# Validate postgresql
sudo -i -u postgres psql -c "select 'hello world' as greetings"

# Print passwords
echo -e "##############################################################"
echo -e "PostgreSQL password for 'app': ${psql_passwd1}" | sudo tee /tmp/psql.log
echo -e "##############################################################"
echo -e "PostgreSQL password for 'app_debug': ${psql_passwd2}" | sudo tee -a /tmp/psql.log
echo -e "##############################################################"
echo -e "PostgreSQL password for 'app_backup': ${psql_passwd3}" | sudo tee -a /tmp/psql.log
echo -e "##############################################################"
echo -e "PostgreSQL password for 'dmitriy': ${psql_passwd4}" | sudo tee -a /tmp/psql.log
echo -e "##############################################################"
echo -e "Passwords are stored in /tmp/psql.log"

# Allow loopback and established connections
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow SSH
sudo iptables -A INPUT -p tcp -m state --state NEW --dport 222 -j ACCEPT

# Allow connections to PostgreSQL from trusted subnets
sudo iptables -A INPUT -p tcp -m state --state NEW --dport 5432 \
  -m iprange --src-range 192.168.0.193-192.168.0.222 -j ACCEPT

sudo iptables -A INPUT -p tcp -m state --state NEW --dport 5432 \
  -m iprange --src-range 172.16.0.1-172.16.0.159 -j ACCEPT

sudo iptables -A INPUT -p tcp -m state --state NEW --dport 5432 \
  -m iprange --src-range 192.168.88.108-192.168.88.149 -j ACCEPT

# Allow outbound, drop everything else
sudo iptables -A OUTPUT -j ACCEPT
sudo iptables -A INPUT -j DROP
sudo iptables -A FORWARD -j DROP

# sudo -i -u postgres psql -c "DROP DATABASE IF EXISTS application; \
#   DROP ROLE IF EXISTS app; DROP ROLE IF EXISTS app_backup; \
#   DROP ROLE IF EXISTS app_debug; DROP ROLE IF EXISTS dmitriy;"
# sudo apt-get -qq --purge remove postgresql \
#   && sudo apt-get purge -qq postgresql* \
#   && sudo apt-get -qq --purge remove postgresql
