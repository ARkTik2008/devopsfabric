#!/bin/bash
#
# This script generates 10K random pairs "key-value" and inserts them on
# Redis server.
# Example of a pair: key="3796HafI" value="jmr+6TOPamceIOx28ogfByoS7+v"
#

set -e

for N in $(seq 1 10000); do
  key=$((1 + $RANDOM % 1000000))$(openssl rand -base64 48 | cut -c1-$((1 + $RANDOM % 10)))
  value=$(openssl rand -base64 48 | cut -c1-$((1 + $RANDOM % 48)))
  redis-cli SET "$key" "$value"
  echo "$key" "$value"
done
