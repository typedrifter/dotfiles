#!/bin/bash
# mango_superz.sh - Float first (auto 75%), then move, then center
STATE_DIR="/tmp/mango_superz_states"
mkdir -p "$STATE_DIR"

FLOATING=$(mmsg -f | awk '{print $3}')
APPID=$(mmsg -g -c | awk '/appid/ {print $3}')
TITLE=$(mmsg -g -c | awk '/title/ {print $3}')
TAGS_INFO=$(mmsg -g -t)
STATE_FILE="$STATE_DIR/${APPID}_${TITLE}"

if [ "$FLOATING" = "1" ]; then
    # RESTORE
    ORIGIN_TAG=$(cat "$STATE_FILE" 2>/dev/null)
    mmsg -d togglefloating
    if [ -n "$ORIGIN_TAG" ]; then
        mmsg -d "tag,$ORIGIN_TAG"
        rm -f "$STATE_FILE"
    fi
else
    # FLOAT
    CURRENT_TAG=$(echo "$TAGS_INFO" | awk '/tag [0-9]/ && $6==1 {print $3}')
    CLIENTS_ON_TAG=$(echo "$TAGS_INFO" | awk -v t="$CURRENT_TAG" '/tag [0-9]/ && $3==t {print $5}')
    NEXT_FREE=$(echo "$TAGS_INFO" | awk '/tag [0-9]/ && $5==0 {print $3; exit}')

    echo "$CURRENT_TAG" > "$STATE_FILE"

    # 1. Float on current tag (mango auto-sizes to ~75% of screen)
    mmsg -d togglefloating
    sleep 0.1

    # 2. Move to next free tag if needed
    if [ "$CLIENTS_ON_TAG" -gt 1 ] && [ -n "$NEXT_FREE" ] && [ "$NEXT_FREE" != "$CURRENT_TAG" ]; then
        mmsg -d "tag,$NEXT_FREE"
        sleep 0.2
    fi

    # 3. Center on the new tag
    mmsg -d centerwin
fi
