#!/bin/bash

# Extract values
# SSID=$(ipconfig getsummary en0 | awk -F ' SSID : '  '/ SSID : / {print $2}')
SSID=$(/usr/sbin/ipconfig getsummary en0 | awk -F' : ' '/ SSID/ { print $2 }')
# Debugging
echo "SSID: $SSID"

# Handle missing SSID or SketchyBar item
if [ -z "$SSID" ]; then
  sketchybar --set "$NAME" label="DC" icon=󰖩 2>/dev/null
else
  sketchybar --set "$NAME" label="$SSID" icon=󰖩 2>/dev/null
fi

POPUP_OFF="sketchybar --set wifi.control popup.drawing=off"
POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"
