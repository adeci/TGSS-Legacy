#!/bin/bash

LOG_FILE="./start_servers.log"

# Add new servers here in the format ["SessionName"]="/path/to/command"
declare -A servers=(
	["minecraft_example"]="/home/server/server_scripts/minecraft/example.sh"
)

start_server_session() {
    SESSION_NAME=$1
    COMMAND=$2
    SOCKET_PATH="/var/tmux/shared-socket"

    if [ ! -e $SOCKET_PATH ] || [ "$(stat -c '%a' $SOCKET_PATH)" != "777" ]; then
        chmod 777 $SOCKET_PATH
    fi

    tmux -S $SOCKET_PATH start-server

    # Existing sessions will not be restarted/will be ignored
    if ! tmux -S $SOCKET_PATH has-session -t $SESSION_NAME 2>/dev/null; then
        tmux -S $SOCKET_PATH new-session -d -s $SESSION_NAME "$COMMAND"
        echo "[$(date)] Session $SESSION_NAME has been created with command: $COMMAND"
    else
        echo "[$(date)] Session $SESSION_NAME already exists. Skipping start command."
    fi
} >> $LOG_FILE 2>&1

for session_name in "${!servers[@]}"; do
    start_server_session "$session_name" "${servers[$session_name]}"
done

