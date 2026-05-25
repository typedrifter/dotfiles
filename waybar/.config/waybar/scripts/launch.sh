#!/bin/bash

killall -9 waybar 2>/dev/null
sleep 0.5

LOGDIR="${XDG_DATA_HOME:-$HOME/.local/share}/waybar"
LOGFILE="$LOGDIR/waybar.log"
mkdir -p "$LOGDIR"

while true; do
    waybar -l debug >> "$LOGFILE" 2>&1
    sleep 60
done &
disown
