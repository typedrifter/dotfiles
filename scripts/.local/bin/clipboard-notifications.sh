#!/bin/bash

content=$(cat)

notify-send -- "Clipboard" "$content"
