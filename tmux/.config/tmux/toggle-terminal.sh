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

# Check saved terminal pane location (session-level, works from any window)
TERM_PANE=""
SAVED_LOCATION=$(tmux show-options -s -v "@terminal-pane" 2>/dev/null)
if [ -n "$SAVED_LOCATION" ]; then
    SAVED_WIN=$(echo "$SAVED_LOCATION" | cut -d. -f1)
    SAVED_PANE=$(echo "$SAVED_LOCATION" | cut -d. -f2)
    if [ -n "$SAVED_PANE" ]; then
        PANE_EXISTS=$(tmux list-panes -t "$CURRENT_SESSION:$SAVED_WIN" -F '#{pane_index}' 2>/dev/null | grep -c "^${SAVED_PANE}$")
        if [ "$PANE_EXISTS" -gt 0 ]; then
            TERM_PANE="$CURRENT_SESSION $SAVED_WIN $SAVED_PANE"
        fi
    fi
fi

# Fall back to finding a pane running the user's shell
if [ -z "$TERM_PANE" ]; then
    SHELL_CMD=$(basename "$SHELL")
    TERM_PANE=$(tmux list-panes -t "$CURRENT_SESSION" -F '#{session_name} #{window_index} #{pane_index} #{pane_current_command}' | awk -v cmd="$SHELL_CMD" '$4 == cmd {print $1, $2, $3}' | head -1)
fi

# Fall back to checking for a window named "terminal"
if [ -z "$TERM_PANE" ]; then
    TERM_WINDOW=$(tmux list-windows -t "$CURRENT_SESSION" -F '#{window_index} #{window_name}' | awk '$2 == "terminal" {print $1}' | head -1)
    if [ -n "$TERM_WINDOW" ]; then
        TERM_PANE_INDEX=$(tmux list-panes -t "$CURRENT_SESSION:$TERM_WINDOW" -F '#{pane_index}' | head -1)
        TERM_PANE="$CURRENT_SESSION $TERM_WINDOW $TERM_PANE_INDEX"
    fi
fi

save_term_location() {
    tmux set-option -s "@terminal-pane" "$1"
}

clear_term_location() {
    tmux set-option -s -u "@terminal-pane"
}

if [ -n "$TERM_PANE" ]; then
    read -r TERM_SESSION TERM_WINDOW TERM_PANE_INDEX <<< "$TERM_PANE"

    if [ "$TERM_SESSION" = "$CURRENT_SESSION" ] && [ "$TERM_WINDOW" = "$CURRENT_WINDOW" ]; then
        # Terminal pane is in current window — break it out to its own window, stay here
        tmux break-pane -d -s "$TERM_SESSION:$TERM_WINDOW.$TERM_PANE_INDEX" -n "terminal"
        clear_term_location
    else
        # Terminal is in another window — create a full-width bottom split and swap it in
        tmux split-window -d -v -f -p 30 -t "$CURRENT_SESSION:$CURRENT_WINDOW"
        BOTTOM_PANE=$(tmux list-panes -t "$CURRENT_SESSION:$CURRENT_WINDOW" -F '#{pane_index}' | sort -n | tail -1)
        tmux swap-pane -s "$TERM_SESSION:$TERM_WINDOW.$TERM_PANE_INDEX" -t "$CURRENT_SESSION:$CURRENT_WINDOW.$BOTTOM_PANE"
        tmux kill-pane -t "$TERM_SESSION:$TERM_WINDOW.$TERM_PANE_INDEX"
        save_term_location "$CURRENT_WINDOW.$BOTTOM_PANE"
    fi
else
    # No terminal pane exists — create a full-width 30% bottom split
    tmux split-window -v -f -p 30 -t "$CURRENT_SESSION:$CURRENT_WINDOW"
    NEW_PANE=$(tmux list-panes -t "$CURRENT_SESSION:$CURRENT_WINDOW" -F '#{pane_index}' | sort -n | tail -1)
    save_term_location "$CURRENT_WINDOW.$NEW_PANE"
fi
