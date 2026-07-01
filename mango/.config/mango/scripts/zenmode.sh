#!/bin/bash
# Toggle zen mode on the CURRENT TAG ONLY.

MON=$(mmsg get all-monitors | jq -r '.monitors[0].name')
TAG=$(mmsg get tags "$MON" | jq -r '.tags[] | select(.is_active==true) | .index')

LAYOUT=$(mmsg get tags "$MON" | jq -r '.tags[] | select(.is_active==true) | .layout')

case "$LAYOUT" in
    T)  LAYOUT_NAME="tile" ;;
    S)  LAYOUT_NAME="scroller" ;;
    G)  LAYOUT_NAME="grid" ;;
    M)  LAYOUT_NAME="monocle" ;;
    K)  LAYOUT_NAME="deck" ;;
    CT) LAYOUT_NAME="center_tile" ;;
    RT) LAYOUT_NAME="right_tile" ;;
    VS) LAYOUT_NAME="vertical_scroller" ;;
    VT) LAYOUT_NAME="vertical_tile" ;;
    VG) LAYOUT_NAME="vertical_grid" ;;
    VK) LAYOUT_NAME="vertical_deck" ;;
    DW) LAYOUT_NAME="dwindle" ;;
    F)  LAYOUT_NAME="fair" ;;
    VF) LAYOUT_NAME="vertical_fair" ;;
esac

echo $LAYOUT
echo $LAYOUT_NAME

STATE="/tmp/mango_zen_tag_${TAG}_state"

if [ ! -f "$STATE" ]; then
    echo "Saving original layout of $MON - $TAG : $LAYOUT_NAME"
    echo "$LAYOUT_NAME" > "$STATE"

    mmsg dispatch setsmartgaps,0
    mmsg dispatch setlayout,monocle
    # mmsg dispatch setgaps,600,300,0,0
    mmsg dispatch setgaps,600,300,0,0
    mmsg dispatch setunfocusopacity,0.0
    mmsg dispatch setfocusopacity,.9
else
    echo "Restoring original layout of $MON - $TAG : $(cat "$STATE")"

    mmsg dispatch defaultopacity
    mmsg dispatch setlayout,"$(cat "$STATE")"
    mmsg dispatch setsmartgaps,1
    mmsg dispatch defaultgaps

    rm -f "$STATE"
fi
