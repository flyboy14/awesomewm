#!/bin/bash
#case "$1" in
#    "up")
#          xbacklight -inc 25
	#$SETVOL --increase $STEP
#          ;;
#  "down")
#          xbacklight -dec 25
	#$SETVOL --decrease $STEP
#	        ;;
#esac

# Get current volume and state
VALUE=$(cat /sys/class/backlight/intel_backlight/brightness)
  if [ $VALUE -le 900 ]; then
    echo 'show_smth(nil, nil,  "'$HOME/.config/awesome/themes/dark_grey/icons/bri_0_x16.png'", 2, nil, nil, nil, nil)' | awesome-client
  elif [ $VALUE -lt 1800 ]; then
    echo 'show_smth(nil, nil,  "'$HOME/.config/awesome/themes/dark_grey/icons/bri_25_x16.png'", 2, nil, nil, nil, nil)' | awesome-client
  elif [ $VALUE -lt 2900 ]; then
    echo 'show_smth(nil, nil,  "'$HOME/.config/awesome/themes/dark_grey/icons/bri_50_x16.png'", 2, nil, nil, nil, nil)' | awesome-client
  elif [ $VALUE -lt 3800 ]; then
    echo 'show_smth(nil, nil,  "'$HOME/.config/awesome/themes/dark_grey/icons/bri_75_x16.png'", 2, nil, nil, nil, nil)' | awesome-client
  elif [ $VALUE -lt 4500 ]; then
    echo 'show_smth(nil, nil,  "'$HOME/.config/awesome/themes/dark_grey/icons/bri_100_x16.png'", 2, nil, nil, nil, nil)' | awesome-client
  fi
exit 0
