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
VOLUME=$($SETVOL --get-volume)
STATE=$($SETVOL --get-mute)
if [[ "$STATE" == "true" ]]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_muted_x16.png'", 2, nil, nil, nil, nil)' | awesome-client 
else
if [[ $VOLUME == "0" ]]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_0_x16.png'", 2, nil, nil, nil, nil)' | awesome-client  
elif [[ $VOLUME -lt 9 ]]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_5_x16.png'", 2, nil, nil, nil, nil)' | awesome-client 
elif [[ $VOLUME -lt 14 ]]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_10_x16.png'", 2, nil, nil, nil, nil)' | awesome-client 
elif [[ $VOLUME -lt 19 ]]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_15_x16.png'", 2, nil, nil, nil, nil)' | awesome-client 
elif [[ $VOLUME -lt 24 ]]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_21_x16.png'", 2, nil, nil, nil, nil)' | awesome-client 
elif [[ $VOLUME -lt 29 ]]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_27_x16.png'", 2, nil, nil, nil, nil)' | awesome-client 
elif [[ $VOLUME -lt 34 ]]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_32_x16.png'", 2, nil, nil, nil, nil)' | awesome-client 
elif [[ $VOLUME -lt 39 ]]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_38_x16.png'", 2, nil, nil, nil, nil)' | awesome-client 
elif [[ $VOLUME -lt 44 ]]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_44_x16.png'", 2, nil, nil, nil, nil)' | awesome-client 
elif [[ $VOLUME -lt 49 ]]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_51_x16.png'", 2, nil, nil, nil, nil)' | awesome-client    
elif [[ $VOLUME -lt 54 ]]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_56_x16.png'", 2, nil, nil, nil, nil)' | awesome-client 
elif [[ $VOLUME -lt 59 ]]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_62_x16.png'", 2, nil, nil, nil, nil)' | awesome-client 
elif [[ $VOLUME -lt 64 ]]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_68_x16.png'", 2, nil, nil, nil, nil)' | awesome-client 
elif [[ $VOLUME -lt 69 ]]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_75_x16.png'", 2, nil, nil, nil, nil)' | awesome-client 
elif [[ $VOLUME -lt 74 ]]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_83_x16.png'", 2, nil, nil, nil, nil)' | awesome-client 
elif [[ $VOLUME -lt 79 ]]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_88_x16.png'", 2, nil, nil, nil, nil)' | awesome-client 
elif [[ $VOLUME -lt 84 ]]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_94_x16.png'", 2, nil, nil, nil, nil)' | awesome-client 
elif [[ $VOLUME -lt 101 ]]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_100_x16.png'", 2, nil, nil, nil, nil)' | awesome-client 
fi
fi

exit 0
