#!/bin/bash
#
# This script installs certbot and config NGINX with A+ SSL Test rating.
# Certbot man: https://certbot.eff.org/instructions?ws=nginx&os=ubuntufocal
#
# Usage: sudo ./nginx_config.sh
#

set -e

# check for root
if [[ "$(id -u)" != "0" ]];then
  echo "This script must be run as root" 1>&2
  exit 1
fi

# ensuring that we have the latest version of snapd
snap install core; sudo snap refresh core

# installing Certbot
snap install --classic certbot

# prepare the Certbot
ln -s /snap/bin/certbot /usr/bin/certbot

# deleting old certificate
certbot revoke --cert-name dmitriy.fabric.baikalteam.com
certbot delete --cert-name dmitriy.fabric.baikalteam.com

# getting new certificate if we need not to stop the webserver
certbot certonly --webroot --webroot-path /var/www/dmitriy.fabric.baikalteam.com/html \
  --domain dmitriy.fabric.baikalteam.com

# validating sheduled certificate renew
# systemctl list-timers

# testing automatic renewal
# certbot renew --dry-run
