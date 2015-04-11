#!/bin/bash
TO=2
case "$1" in
    "up")
          xbacklight -inc 25
  #$SETVOL --increase $STEP
          ;;
  "down")
          xbacklight -dec 25
  #$SETVOL --decrease $STEP
          ;;
 "none")
  TO=0
    ;;  
esac

# Get current volume and state
VALUE=$(cat /sys/class/backlight/intel_backlight/brightness)
if [ "$TO" == "2" ]; then
  if [ "$VALUE" == "0" ]; then
    echo 'show_smth("", "",  "'$HOME/.config/awesome/themes/color_arrows/icons/bri_0_x16.png'", 2, "#C2C2A4", nil, nil)' | awesome-client  
  elif [ $VALUE -lt 1110 ]; then
    echo 'show_smth("", "",  "'$HOME/.config/awesome/themes/color_arrows/icons/bri_25_x16.png'", 2, "#C2C2A4", nil, nil)' | awesome-client 
  elif [ $VALUE -lt 2219 ]; then
    echo 'show_smth("", "",  "'$HOME/.config/awesome/themes/color_arrows/icons/bri_50_x16.png'", 2, "#C2C2A4", nil, nil)' | awesome-client 
  elif [ $VALUE -lt 3328 ]; then
    echo 'show_smth("", "",  "'$HOME/.config/awesome/themes/color_arrows/icons/bri_75_x16.png'", 2, "#C2C2A4", nil, nil)' | awesome-client
  elif [ $VALUE -lt 4438 ]; then
    echo 'show_smth("", "",  "'$HOME/.config/awesome/themes/color_arrows/icons/bri_100_x16.png'", 2, "#C2C2A4", nil, nil)' | awesome-client  
  fi
fi
if [ "$TO" == "0" ]; then
  if [ "$VALUE" == "0" ]; then
    echo 'show_smth("", "",  "'$HOME/.config/awesome/themes/color_arrows/icons/bri_0_x16.png'", 0, "#C2C2A4", nil, nil)' | awesome-client  
  elif [ $VALUE -lt 1110 ]; then
    echo 'show_smth("", "",  "'$HOME/.config/awesome/themes/color_arrows/icons/bri_25_x16.png'", 0, "#C2C2A4", nil, nil)' | awesome-client 
  elif [ $VALUE -lt 2219 ]; then
    echo 'show_smth("", "",  "'$HOME/.config/awesome/themes/color_arrows/icons/bri_50_x16.png'", 0, "#C2C2A4", nil, nil)' | awesome-client 
  elif [ $VALUE -lt 3328 ]; then
    echo 'show_smth("", "",  "'$HOME/.config/awesome/themes/color_arrows/icons/bri_75_x16.png'", 0, "#C2C2A4", nil, nil)' | awesome-client
  elif [ $VALUE -lt 4438 ]; then
    echo 'show_smth("", "",  "'$HOME/.config/awesome/themes/color_arrows/icons/bri_100_x16.png'", 0, "#C2C2A4", nil, nil)' | awesome-client  
  fi
fi
exit 0
