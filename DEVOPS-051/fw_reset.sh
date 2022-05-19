#!/bin/bash
#
# This script is used to securely return the firewall to default settings.
# Running in a tmux session, it allows to securely change the firewall rules.
# The script waits 10 minutes from its start and disables the firewall,
# after that it waits another 10 minutes and restarts the server. In total, you
# have 20 minutes before restarting the server.
#
# If the countdown timer script (countdown.sh) is placed near this script,
# the remaining minutes will be displayed.
#
# Usage: sudo ./fw_reset.sh
#
# Attach a running session: sudo tmux attach -t fw_reset
# Detach a running session: sudo tmux detach
# Stop and exit a session: sudo tmux kill-session -t fw_reset
#

set -e

# checking for root
if [[ "$(id -u)" != "0" ]];then
  echo "This script must be run as root" 1>&2
  exit 1
fi

tmux new-session -d -s fw_reset
tmux split-window -v
tmux select-pane -U
tmux send-keys -t fw_reset 'bash ./countdown.sh' C-m
tmux select-pane -D
tmux send-keys -t fw_reset "sleep 600 \
  && iptables-restore < /etc/iptables-conf/iptables_rules.backup \
  && sleep 600 \
  && reboot" C-m
tmux attach-session -d -t fw_reset
