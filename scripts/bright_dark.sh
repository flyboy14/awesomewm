#!/bin/bash

STEP=750
BRI_CUR=$(cat /sys/class/backlight/intel_backlight/actual_brightness)

case "$1" in
    "up")
			RES=$(($STEP+$BRI_CUR))
			if [ $RES -lt 7500 ]; then
				sudo bash -c "echo $RES > /sys/class/backlight/intel_backlight/brightness"
			else
				sudo bash -c "echo 7500 > /sys/class/backlight/intel_backlight/brightness"
			fi
			;;
  "down")
			RES=$(($BRI_CUR-$STEP))
			if [ $RES -gt 0 ]; then
				sudo bash -c "echo $RES > /sys/class/backlight/intel_backlight/brightness"
			else
				sudo bash -c "echo 0 > /sys/class/backlight/intel_backlight/brightness"
			fi
	        ;;
esac

# Get current brightness
VALUE=$(cat /sys/class/backlight/intel_backlight/brightness)
  if [ $VALUE -le 1501 ]; then
    echo 'show_smth(nil, nil,  "'$HOME/.config/awesome/themes/dark_grey/icons/bri_0_x16.png'", 2, nil, nil, nil, nil)' | awesome-client
  elif [ $VALUE -lt 3001 ]; then
    echo 'show_smth(nil, nil,  "'$HOME/.config/awesome/themes/dark_grey/icons/bri_25_x16.png'", 2, nil, nil, nil, nil)' | awesome-client
  elif [ $VALUE -lt 4501 ]; then
    echo 'show_smth(nil, nil,  "'$HOME/.config/awesome/themes/dark_grey/icons/bri_50_x16.png'", 2, nil, nil, nil, nil)' | awesome-client
  elif [ $VALUE -lt 6001 ]; then
    echo 'show_smth(nil, nil,  "'$HOME/.config/awesome/themes/dark_grey/icons/bri_75_x16.png'", 2, nil, nil, nil, nil)' | awesome-client
  elif [ $VALUE -lt 7501 ]; then
    echo 'show_smth(nil, nil,  "'$HOME/.config/awesome/themes/dark_grey/icons/bri_100_x16.png'", 2, nil, nil, nil, nil)' | awesome-client
  fi
exit 0

