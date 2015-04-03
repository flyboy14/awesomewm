#!/bin/bash

# Configuration
STEP="6"    # Anything you like.
UNIT="%"   # dB, %, etc.

# Set volume
SETVOL="/usr/bin/amixer -Mqc 0 set Master"
#SETVOL="/usr/bin/pamixer"

case "$1" in
    "up")
          $SETVOL $STEP$UNIT+
	#$SETVOL --increase $STEP
          ;;
  "down")
          $SETVOL $STEP$UNIT-
	#$SETVOL --decrease $STEP
          ;;
  "mute")
          $SETVOL toggle
	#$SETVOL --toggle-mute
          ;;
esac

# Get current volume and state
VOLUME=$(amixer -M -c 0 get Master | grep 'Mono:' | cut -d ' ' -f 6 | sed -e 's/[^0-9]//g')
STATE=$(amixer -c 0 get Master | grep 'Mono:' | grep -o "\[off\]")
# Show volume
if [[ "$STATE" == "true" ]]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_muted_x16.png'", 2, "#121212", nil, nil, nil)' | awesome-client 
else
if [ $VOLUME == "0" ]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_0_x16.png'", 2, "#121212", nil, nil, nil)' | awesome-client  
elif [ $VOLUME == "100" ]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_100_x16.png'", 2, "#121212", nil, nil, nil)' | awesome-client 
elif [ $VOLUME -lt 9 ]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_5_x16.png'", 2, "#121212", nil, nil, nil)' | awesome-client 
elif [ $VOLUME -lt 13 ]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_10_x16.png'", 2, "#121212", nil, nil, nil)' | awesome-client 
elif [ $VOLUME -lt 19 ]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_15_x16.png'", 2, "#121212", nil, nil, nil)' | awesome-client 
elif [ $VOLUME -lt 26 ]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_21_x16.png'", 2, "#121212", nil, nil, nil)' | awesome-client 
elif [ $VOLUME -lt 32 ]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_27_x16.png'", 2, "#121212", nil, nil, nil)' | awesome-client 
elif [ $VOLUME -lt 38 ]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_32_x16.png'", 2, "#121212", nil, nil, nil)' | awesome-client 
elif [ $VOLUME -lt 40 ]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_38_x16.png'", 2, "#121212", nil, nil, nil)' | awesome-client 
elif [ $VOLUME -lt 45 ]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_44_x16.png'", 2, "#121212", nil, nil, nil)' | awesome-client 
elif [ $VOLUME -lt 52 ]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_51_x16.png'", 2, "#121212", nil, nil, nil)' | awesome-client    
elif [ $VOLUME -lt 56 ]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_56_x16.png'", 2, "#121212", nil, nil, nil)' | awesome-client 
elif [ $VOLUME -lt 62 ]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_62_x16.png'", 2, "#121212", nil, nil, nil)' | awesome-client 
elif [ $VOLUME -lt 71 ]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_68_x16.png'", 2, "#121212", nil, nil, nil)' | awesome-client 
elif [ $VOLUME -lt 78 ]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_75_x16.png'", 2, "#121212", nil, nil, nil)' | awesome-client 
elif [ $VOLUME -lt 86 ]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_83_x16.png'", 2, "#121212", nil, nil, nil)' | awesome-client 
elif [ $VOLUME -lt 91 ]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_88_x16.png'", 2, "#121212", nil, nil, nil)' | awesome-client 
elif [ $VOLUME -lt 96 ]; then
  echo 'show_smth(nil, nil, "'$HOME/.config/awesome/themes/dark_grey/icons/vol_94_x16.png'", 2, "#121212", nil, nil, nil)' | awesome-client 
fi
fi
exit 0
