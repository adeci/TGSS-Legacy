#!/bin/bash

RCON_HOST="127.0.0.1"
RCON_PORT="27025"
RCON_PASSWORD="password"
BROADCAST_CMD='rcon -H $RCON_HOST -p $RCON_PORT -P $RCON_PASSWORD -n broadcast "[SAVING...]"'
SAVE_CMD='rcon -H $RCON_HOST -p $RCON_PORT -P $RCON_PASSWORD -n Save'
SHUTDOWN_CMD='rcon -H $RCON_HOST -p $RCON_PORT -P $RCON_PASSWORD -n Shutdown 10'

eval $BROADCAST_CMD
eval $SAVE_CMD
sleep 5
eval $SHUTDOWN_CMD
sleep 10

SOCKET_PATH="/var/tmux/shared-socket"

tmux -S $SOCKET_PATH kill-session -t palworld
