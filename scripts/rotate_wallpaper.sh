#!/bin/bash

# A simple bash script to rotate wallpapers written by flyboy14
# Script finds image files in given directory and randomly picks one file from given. Serching is not recursive by default, but can be changed.
# Put it in your crontab

# USER VARIABLES

# List of directories where all wallpapers lie (separated by simple space)
WPDIRS="$HOME/Pictures/Wallpapers"

# Maximum depth of searching (use value other than 1 if you want recursive directory image search)
DEPTH=1

# Script variables

RANGE=`find $WPDIRS -type f | wc -l`
NUMBER=$RANDOM
let "NUMBER %= $RANGE"

# Never let number be less than 1

if [ "$NUMBER" -eq 0 ]; then
  let "NUMBER += 1"
fi

# Get random wallpaper path

WALL=`find $WPDIRS -maxdepth $DEPTH -type f -exec file {} \; | awk -F: '{if ($2 ~/image/) print $1}'|head -n$NUMBER|tail -n1`

# Now set it using your favourite wallpaper tool (mine is nitrogen + awesomewm)

# Cooperate with X (awesomewm only)

export DISPLAY=":0"
PID=$(pgrep awesome)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

# set wallpaper

sed -e "s:file=.*:file=$WALL:" $HOME/.config/nitrogen/bg-saved.cfg > /tmp/bg-saved.cfg
mv /tmp/bg-saved.cfg $HOME/.config/nitrogen/bg-saved.cfg
echo "set_wallpaper()" | awesome-client
echo "color_systray()" | awesome-client

exit 0
