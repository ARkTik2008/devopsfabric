#!/bin/bash
#
# A script that sync git repo from bmarley to sdogg.
# Usage: ./sync.sh

set -e
sudo rsync -v -rlptgoD --delete-before \
    -e "ssh -p 222 -o StrictHostKeyChecking=no \
    -i /home/bmarley/.ssh/sdogg/id_ed25519" \
    /home/bmarley/WindowsShare/pashkov_dmitriy/ \
    sdogg@ubuntu:/home/sdogg/synced/
