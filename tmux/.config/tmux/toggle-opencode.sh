#!/bin/bash

# Toggle an opencode window: switch to it if it exists, otherwise create it.

SESSION=$(tmux display-message -p '#{session_name}')

# Check if a window named "opencode" exists in the current session
if tmux list-windows -t "$SESSION" -F '#{window_name}' | grep -qx 'opencode'; then
    tmux select-window -t "$SESSION:opencode"
else
    tmux new-window -n opencode "opencode"
fi
