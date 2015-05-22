#!/bin/bash
DATE=`/bin/date "+%0Y%0m%0d-%0k%0M%0S"`
import "$HOME/Pictures/Screenshots/screenshot-$DATE.png"
echo 'naughty.notify({ text = "Shot taken", icon = iconsdir .. "/camera.svg", timeout = 1.5 })' | awesome-client
