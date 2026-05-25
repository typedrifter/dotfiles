#!/usr/bin/bash
swayidle \
  before-sleep 'qs -c quicklock' \
	timeout 600 'wlr-dpms off' \
	resume 'wlr-dpms on' \
	timeout 300 'qs -c quicklock' \
	resume ''
