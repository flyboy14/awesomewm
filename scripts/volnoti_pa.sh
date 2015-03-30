#!/bin/bash

# Configuration
STEP="5"    # Anything you like.
UNIT="%"   # dB, %, etc.

# Set volume
#SETVOL="/usr/bin/amixer -Mqc 0 set Master"
SETVOL="/usr/bin/pamixer"

case "$1" in
    "up")
          #$SETVOL $STEP$UNIT+
	$SETVOL --increase $STEP
          ;;
  "down")
          #$SETVOL $STEP$UNIT-
	$SETVOL --decrease $STEP
          ;;
  "mute")
          #$SETVOL toggle
	$SETVOL --toggle-mute
          ;;
esac

# Get current volume and state
#VOLUME=$(amixer -M get Master | grep 'Mono:' | cut -d ' ' -f 6 | sed -e 's/[^0-9]//g')
#STATE=$(amixer get Master | grep 'Mono:' | grep -o "\[off\]")
VOLUME=$($SETVOL --get-volume)
STATE=$($SETVOL --get-mute)
# Show volume with volnoti
#if [[ -n $STATE ]]; then
if [[ "$STATE" == "true"  ]]; then
  volnoti-show -m
else
  volnoti-show $VOLUME
fi

exit 0
