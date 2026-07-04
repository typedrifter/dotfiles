#!/bin/bash
(echo "RETRIEVE_FOLDER_STATUS:$HOME/Nextcloud"; sleep infinity) \
| socat - UNIX-CONNECT:"${XDG_RUNTIME_DIR}/Nextcloud/socket" \
| stdbuf -oL grep -oP '^STATUS:\K[^:]+' \
| while read -r status; do
    printf '{"alt":"%s","class":"%s"}\n' "$status" "$status"
  done
