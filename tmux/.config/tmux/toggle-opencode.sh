#!/bin/bash

CURRENT_SESSION=$(tmux display-message -p '#{session_name}')
CURRENT_WINDOW=$(tmux display-message -p '#{window_index}')
CURRENT_PANE=$(tmux display-message -p '#{pane_index}')

# If the current pane is not nvim, try to switch to a pane running nvim in the current window
CURRENT_CMD=$(tmux display-message -p '#{pane_current_command}')
if [ "$CURRENT_CMD" != "nvim" ]; then
    NVIM_PANE=$(tmux list-panes -t "$CURRENT_SESSION:$CURRENT_WINDOW" -F '#{pane_index} #{pane_current_command}' | awk '$2 == "nvim" {print $1}' | head -1)
    if [ -n "$NVIM_PANE" ]; then
        tmux select-pane -t "$CURRENT_SESSION:$CURRENT_WINDOW.$NVIM_PANE"
        CURRENT_PANE=$NVIM_PANE
    fi
fi

# Find a pane running opencode in the current session
OPEN_PANE=$(tmux list-panes -t "$CURRENT_SESSION" -F '#{session_name} #{window_index} #{pane_index} #{pane_current_command}' | awk '$4 == "opencode" {print $1, $2, $3}' | head -1)

# If not found by command, check for a window named "opencode"
if [ -z "$OPEN_PANE" ]; then
    OPEN_WINDOW=$(tmux list-windows -t "$CURRENT_SESSION" -F '#{window_index} #{window_name}' | awk '$2 == "opencode" {print $1}' | head -1)
    if [ -n "$OPEN_WINDOW" ]; then
        OPEN_PANE_INDEX=$(tmux list-panes -t "$CURRENT_SESSION:$OPEN_WINDOW" -F '#{pane_index}' | head -1)
        OPEN_PANE="$CURRENT_SESSION $OPEN_WINDOW $OPEN_PANE_INDEX"
    fi
fi

if [ -n "$OPEN_PANE" ]; then
    read -r OPEN_SESSION OPEN_WINDOW OPEN_PANE_INDEX <<< "$OPEN_PANE"

    if [ "$OPEN_SESSION" = "$CURRENT_SESSION" ] && [ "$OPEN_WINDOW" = "$CURRENT_WINDOW" ]; then
        # Opencode pane is in current window — break it out to its own window, stay here
        tmux break-pane -d -s "$OPEN_SESSION:$OPEN_WINDOW.$OPEN_PANE_INDEX" -n "opencode"
    else
        # Opencode is in another window — join it to current window as a right 30% split
        tmux join-pane -s "$OPEN_SESSION:$OPEN_WINDOW.$OPEN_PANE_INDEX" -t "$CURRENT_SESSION:$CURRENT_WINDOW.$CURRENT_PANE" -h -l '30%'
    fi
else
    # No opencode pane exists — create a 25% right split
    tmux split-window -h -p 25 -t "$CURRENT_SESSION:$CURRENT_WINDOW" "opencode"
fi
