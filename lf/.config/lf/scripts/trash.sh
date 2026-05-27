#!/bin/bash

set -e

nocomfirm=0
while getopts "y" VARNAME; do
    case $VARNAME in
      y) nocomfirm=1;;
    esac
done

shift $((OPTIND - 1))



input="$1"

mapfile -t files <<< "$input"
count=${#files[@]}

if [[ $count -eq 1 ]]; then
    prompt="Send '${files[0]}' to the trash? [Y/n]: "
    done_msg="'${files[0]}' was sent to the trash"
else
    prompt="Send ${count} elements to the trash? [Y/n]: "
    done_msg="${count} elements were sent to the trash"
fi

if [[ $nocomfirm -ne 1 ]]
then
printf "%s" "$prompt"
read -r confirmation
fi

if [[ "$confirmation" =~ ^([yY]|)$ ]]; 
then
    trashy -- "${files[@]}"
    echo "$done_msg"
else 
  echo ""
fi
