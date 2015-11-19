#!/bin/bash
mkdir -p ~/ScreenRecords
DATE=`/bin/date "+%0Y%0m%0d-%0k%0M%0S"`
NAME="record-$DATE.mp4"
echo 'naughty.notify({ title = "Recording in progress", icon = "'$HOME/.config/awesome/icons/comicdee/media-record.png'",timeout = 2, bg = wibox_color(), border_width = 0 })' | awesome-client
ffmpeg -f x11grab -video_size 1366x768 -i $DISPLAY $HOME/ScreenRecords/$NAME
echo 'naughty.notify({ title = "Record saved as '$NAME'", icon = "'$HOME/.config/awesome/icons/comicdee/media-arrow.png'",timeout = 4, bg = wibox_color(), border_width = 0 })' | awesome-client
