#!/bin/bash

SEND_COMMAND_SCRIPT="/home/server/server_scripts/send_command"

SESSION_NAME="minecraft2"

$SEND_COMMAND_SCRIPT $SESSION_NAME "say SERVER RESTARTING IN 10 MINUTES!"

sleep 540

$SEND_COMMAND_SCRIPT $SESSION_NAME "say SERVER RESTARTING IN 1 MINUTE!"

sleep 60

$SEND_COMMAND_SCRIPT $SESSION_NAME "stop"

sleep 30

SOCKET_PATH="/var/tmux/shared-socket"

tmux -S $SOCKET_PATH kill-session -t $SESSION_NAME
echo "[$(date)] Minecraft2 tmux session just killed. kill_minecraft_server_2 script is completed."
