#!/bin/bash

WPDIR="$HOME/Pictures/Wallpapers"
RANGE=`find $WPDIR |wc -l`
NUMBER=$RANDOM
let "NUMBER %= $RANGE"
WALL=`find $WPDIR|head -n$NUMBER|tail -n1`
echo $WALL
sed -e "s:file=.*:file=$WALL:" $HOME/.config/nitrogen/bg-saved.cfg > /tmp/bg-saved.cfg
mv /tmp/bg-saved.cfg $HOME/.config/nitrogen/bg-saved.cfg

echo "set_wallpaper()"|awesome-client
