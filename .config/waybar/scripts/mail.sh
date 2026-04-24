# #!/usr/bin/env bash
#
# ROOT="$HOME/.local/share/mail"
#
# count() {
#   find "$ROOT" -type f -path "*/INBOX/new/*" 2>/dev/null | wc -l
# }
#
# emit() {
#   echo "$(count)"
# }
#
# watch_dir() {
#   local dir="$1"
#
#   while true; do
#     inotifywait -q \
#       -e create -e delete -e moved_to -e moved_from \
#       "$dir" >/dev/null 2>&1
#
#     emit
#   done
# }
#
# emit
#
# # launch watchers only on INBOX/new dirs
# while IFS= read -r dir; do
#   watch_dir "$dir" &
# done < <(find "$ROOT" -type d -path "*/INBOX/new")
#
# wait
#
#!/usr/bin/env bash

ROOT="$HOME/.local/share/mail"

emit() {
  if find "$ROOT" -type f -path "*/INBOX/new/*" -print -quit 2>/dev/null | grep -q .; then
    printf "\n"
  else
    printf "\n"
  fi
}

emit

find "$ROOT" -type d -path "*/INBOX/new" -print0 |
  xargs -0 inotifywait -mq \
    -e create -e delete -e moved_to -e moved_from \
    --fromfile - >/dev/null |
while read -r _; do
  emit
done
