#!/bin/bash
#
# This script starts another ('tee_exec_script.sh') script in 3 different
# panes of tmux, respectively with 3 different arguments: "ps auxww",
# "top" and "vmstat 5".
# Usage: ./tmux_starter.sh

set -e

tmux new-session -d -s monitoring
tmux split-window -v
tmux select-pane -U
tmux send-keys -t monitoring 'bash ./tee_exec_script.sh "ps auxww"' C-m
tmux select-pane -D
tmux split-window -h
tmux select-pane -L
tmux send-keys -t monitoring 'bash ./tee_exec_script.sh top' C-m
tmux select-pane -R
tmux send-keys -t monitoring 'bash ./tee_exec_script.sh "vmstat 5"' C-m
tmux attach-session -d -t monitoring
