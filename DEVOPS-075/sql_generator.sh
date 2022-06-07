#!/bin/bash
#
# This script ganarates 1000 random and unique lines for MySQL tables
# 'ap', 'controller' and 'text_configs'.
#

set -e

for ((i=1;i<=1000;i++));
  do
    ip=$(printf '%02d.%02d.%02d.%02d\n' $[RANDOM%256] $[RANDOM%256] \
      $[RANDOM%256] $[RANDOM%256])
    name=$(printf '%02d%02d%02d%02d\n' $[RANDOM%256] $[RANDOM%256] \
      $[RANDOM%256] $[RANDOM%256])
    id=$(printf '%02d%02d%02d\n' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])

    config_id=$(printf '%02d%02d%02d\n' $[RANDOM%256] $[RANDOM%256] \
      $[RANDOM%256])
    orig_text=$(printf '%02d%02d\n' $[RANDOM%256] $[RANDOM%256])
    ts=$(printf '%02d%02d\n' $[RANDOM%256] $[RANDOM%256])
    parsed_text=$(printf '%02d%02d\n' $[RANDOM%256] $[RANDOM%256])
    filename=$(printf '%02d%02d\n' $[RANDOM%256] $[RANDOM%256])

    apid=$(printf '%02d%02d%02d\n' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])
    boot=$(printf '%02d%02d%02d%02d%02d%02d\n' $[RANDOM%256] $[RANDOM%256] \
      $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])
    desc=$(printf '%02d%02d%02d%02d%02d%02d\n' $[RANDOM%256] $[RANDOM%256] \
      $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])
    build=$(printf '%02d%02d%02d%02d%02d%02d\n' $[RANDOM%256] $[RANDOM%256] \
      $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])
    loc=$(printf '%02d%02d%02d%02d%02d%02d\n' $[RANDOM%256] $[RANDOM%256] \
      $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])
    enc=$(printf '%02d%02d%02d%02d%02d%02d\n' $[RANDOM%256] $[RANDOM%256] \
      $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])
    mac=$(printf '00-60-2F-%02X-%02X-%02X\n' $[RANDOM%256] $[RANDOM%256] \
      $[RANDOM%256])
    model=$(printf '%02d%02d%02d%02d%02d%02d\n' $[RANDOM%256] $[RANDOM%256] \
      $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])
    power=$(printf '%02d%02d%02d%02d%02d%02d\n' $[RANDOM%256] $[RANDOM%256] \
      $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])

    echo "INSERT INTO controller (contr_id,name,ipaddr) VALUES($id,$name,\
      '$ip');" | mysql -u root application;

    echo "INSERT INTO text_configs (config_id,contr_id,orig_text,download_ts,\
      parsed_text,orig_filename) VALUES($config_id,$id,$orig_text,$ts,\
      $parsed_text,$filename);" | mysql -u root application;

    echo "INSERT INTO ap (contr_id,apid,boot_script,description,building,\
      location,dataplan_encryption,mac_address,model,power_suply,config_id) \
      VALUES($id,$apid,$boot,$desc,$build,$loc,$enc,'$mac',$model,$power,\
      $config_id);" | mysql -u root application;
done
