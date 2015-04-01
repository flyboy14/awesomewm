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
  echo 'show_smth("", "'$HOME/.config/awesome/themes/dark_grey/icons/vol_muted_x16.png'")' | awesome-client 
else
if [ $VOLUME == "0" ]; then
  echo 'show_smth("", "'$HOME/.config/awesome/themes/dark_grey/icons/vol_0_x16.png'")' | awesome-client   
elif [ $VOLUME == "100" ]; then
  echo 'show_smth("", "'$HOME/.config/awesome/themes/dark_grey/icons/vol_100_x16.png'")' | awesome-client
elif [ $VOLUME -lt 10 ]; then
  echo 'show_smth("", "'$HOME/.config/awesome/themes/dark_grey/icons/vol_5_x16.png'")' | awesome-client 
elif [ $VOLUME -lt 15 ]; then
  echo 'show_smth("", "'$HOME/.config/awesome/themes/dark_grey/icons/vol_10_x16.png'")' | awesome-client 
elif [ $VOLUME -lt 20 ]; then
  echo 'show_smth("", "'$HOME/.config/awesome/themes/dark_grey/icons/vol_15_x16.png'")' | awesome-client 
elif [ $VOLUME -lt 26 ]; then
  echo 'show_smth("", "'$HOME/.config/awesome/themes/dark_grey/icons/vol_21_x16.png'")' | awesome-client 
elif [ $VOLUME -lt 31 ]; then
  echo 'show_smth("", "'$HOME/.config/awesome/themes/dark_grey/icons/vol_27_x16.png'")' | awesome-client 
elif [ $VOLUME -lt 37 ]; then
  echo 'show_smth("", "'$HOME/.config/awesome/themes/dark_grey/icons/vol_32_x16.png'")' | awesome-client 
elif [ $VOLUME -lt 42 ]; then
  echo 'show_smth("", "'$HOME/.config/awesome/themes/dark_grey/icons/vol_38_x16.png'")' | awesome-client 
elif [ $VOLUME -lt 48 ]; then
  echo 'show_smth("", "'$HOME/.config/awesome/themes/dark_grey/icons/vol_44_x16.png'")' | awesome-client 
elif [ $VOLUME -lt 53 ]; then
  echo 'show_smth("", "'$HOME/.config/awesome/themes/dark_grey/icons/vol_51_x16.png'")' | awesome-client    
elif [ $VOLUME -lt 59 ]; then
  echo 'show_smth("", "'$HOME/.config/awesome/themes/dark_grey/icons/vol_56_x16.png'")' | awesome-client 
elif [ $VOLUME -lt 65 ]; then
  echo 'show_smth("", "'$HOME/.config/awesome/themes/dark_grey/icons/vol_62_x16.png'")' | awesome-client 
elif [ $VOLUME -lt 71 ]; then
  echo 'show_smth("", "'$HOME/.config/awesome/themes/dark_grey/icons/vol_68_x16.png'")' | awesome-client 
elif [ $VOLUME -lt 79 ]; then
  echo 'show_smth("", "'$HOME/.config/awesome/themes/dark_grey/icons/vol_75_x16.png'")' | awesome-client 
elif [ $VOLUME -lt 84 ]; then
  echo 'show_smth("", "'$HOME/.config/awesome/themes/dark_grey/icons/vol_83_x16.png'")' | awesome-client 
elif [ $VOLUME -lt 89 ]; then
  echo 'show_smth("", "'$HOME/.config/awesome/themes/dark_grey/icons/vol_88_x16.png'")' | awesome-client 
elif [ $VOLUME -lt 95 ]; then
  echo 'show_smth("", "'$HOME/.config/awesome/themes/dark_grey/icons/vol_94_x16.png'")' | awesome-client 
fi
fi
exit 0
