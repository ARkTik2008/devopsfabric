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

# one command for getting a certificate and automatically editing nginx
# configuration for turning HTTPS access on
certbot --nginx

# validating sheduled certificate renew
# systemctl list-timers

# testing automatic renewal
# certbot renew --dry-run

# enabling HSTS with more than 1 week duration (satisified A+ SSL Test rating)
cat >> /etc/letsencrypt/options-ssl-nginx.conf <<EOF
add_header Strict-Transport-Security "max-age=63072000;";
EOF
