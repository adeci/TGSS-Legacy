#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <session_name>"
    exit 1
fi

SESSION_NAME=$1

SOCKET_PATH="/var/tmux/shared-socket"

check_active_players() {
    tmux -S $SOCKET_PATH start-server

    if ! tmux -S $SOCKET_PATH has-session -t $SESSION_NAME 2>/dev/null; then
        echo "Session $SESSION_NAME does not exist."
        exit 1
    fi

    tmux -S $SOCKET_PATH send-keys -t $SESSION_NAME C-m

    tmux -S $SOCKET_PATH send-keys -t $SESSION_NAME "list" C-m

    sleep 1

    output=$(tmux -S $SOCKET_PATH capture-pane -t $SESSION_NAME -p -S -5)

    # This regex covers both formats:
    # Format 1: "There are X/Y players online:"
    # Format 2: "There are X of a max of Y players online:"
    players=$(echo "$output" | grep -E "There are [0-9]+(/[0-9]+ players online:| of a max of [0-9]+ players online:)" | tail -n 1 | sed -E 's/.*There are ([0-9]+)(\/[0-9]+| of a max of [0-9]+).*/\1/')

    # Output just the number
    echo "$players"
}

check_active_players

