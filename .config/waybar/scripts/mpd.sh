#!/usr/bin/env bash

update() {
    status=$(mpc status 2>/dev/null) || { echo ""; return; }

    state=$(sed -n '2p' <<< "$status")

    if [[ "$state" == *"[playing]"* ]]; then
        song=$(head -n1 <<< "$status")
        echo "$song"
    else
        echo ""
    fi
}

update

while mpc idle player >/dev/null 2>&1; do
    update
done
