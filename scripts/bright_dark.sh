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
VALUE=$(cat /sys/class/backlight/acpi_video0/brightness)
  if [ $VALUE -le 3 ]; then
    echo 'show_smth(nil, nil,  "'$HOME/.config/awesome/themes/dark_grey/icons/bri_0_x16.png'", 2, nil, nil, nil, nil)' | awesome-client
  elif [ $VALUE -lt 7 ]; then
    echo 'show_smth(nil, nil,  "'$HOME/.config/awesome/themes/dark_grey/icons/bri_25_x16.png'", 2, nil, nil, nil, nil)' | awesome-client
  elif [ $VALUE -lt 10 ]; then
    echo 'show_smth(nil, nil,  "'$HOME/.config/awesome/themes/dark_grey/icons/bri_50_x16.png'", 2, nil, nil, nil, nil)' | awesome-client
  elif [ $VALUE -lt 13 ]; then
    echo 'show_smth(nil, nil,  "'$HOME/.config/awesome/themes/dark_grey/icons/bri_75_x16.png'", 2, nil, nil, nil, nil)' | awesome-client
  elif [ $VALUE -lt 16 ]; then
    echo 'show_smth(nil, nil,  "'$HOME/.config/awesome/themes/dark_grey/icons/bri_100_x16.png'", 2, nil, nil, nil, nil)' | awesome-client
  fi
exit 0
