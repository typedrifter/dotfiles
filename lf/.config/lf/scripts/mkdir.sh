#!/bin/sh
IFS=" "
printf " Create new directory: "
read file
mkdir -p -- "$file"
lf -remote "send $id select $(printf '%q' "$file")"
