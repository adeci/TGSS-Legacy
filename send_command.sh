#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <session_name> <command>"
    exit 1
fi

SESSION_NAME=$1
COMMAND=$2

SOCKET_PATH="/var/tmux/shared-socket"

send_command_to_session() {
    tmux -S $SOCKET_PATH start-server

    if ! tmux -S $SOCKET_PATH has-session -t $SESSION_NAME 2>/dev/null; then
        echo "Session $SESSION_NAME does not exist."
        exit 1
    fi

    tmux -S $SOCKET_PATH send-keys -t $SESSION_NAME C-m "$COMMAND" C-m
}

send_command_to_session
