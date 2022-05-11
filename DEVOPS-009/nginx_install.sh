#!/bin/bash
#
# This script installs NGINX 1.20.1. For Ubuntu only.
#
# Usage: sudo ./nginx_install.sh
#

set -e

# check for root
if [[ "$(id -u)" != "0" ]];then
  echo "This script must be run as root" 1>&2
  exit 1
fi

# Installing prerequisites
apt update
apt install -y curl gnupg2 ca-certificates lsb-release ubuntu-keyring

# Importing an official nginx signing key
curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
  | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null

# Setting up the repository for stable nginx packages
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
  | tee /etc/apt/sources.list.d/nginx.list

# Setting up repository pinning
echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" \
  | tee /etc/apt/preferences.d/99nginx

apt update
apt install -y nginx=1.20.1*
systemctl start nginx
systemctl enable nginx
#systemctl status nginx
