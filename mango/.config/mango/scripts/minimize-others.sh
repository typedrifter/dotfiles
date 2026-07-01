#!/bin/sh
o=$(mmsg -g -c | grep -E 'title|appid' | sed 's/^[^ ]* //' | tr '\n' '|')
while true; do
  mmsg -d focusstack,next
  c=$(mmsg -g -c | grep -E 'title|appid' | sed 's/^[^ ]* //' | tr '\n' '|')
  [ "$c" = "$o" ] && break
  mmsg -d minimized
done
