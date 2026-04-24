#!/bin/sh

current=$(pactl info | awk -F': ' '/Default Sink/ {print $2}')

next=$(pactl list short sinks | awk '{print $2}' | awk -v cur="$current" '
{
  if (found) { print; exit }
  if ($0 == cur) found = 1
}
END {
  if (!found) exit 1
}')

# wrap around if we were on last sink
if [ -z "$next" ]; then
  next=$(pactl list short sinks | awk 'NR==1{print $2}')
fi

pactl set-default-sink "$next"

# move active streams
pactl list short sink-inputs | awk '{print $1}' | while read -r id; do
  pactl move-sink-input "$id" "$next"
done
