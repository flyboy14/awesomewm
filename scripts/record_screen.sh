#!/bin/bash
DATE=`/bin/date "+%0Y%0m%0d-%0k%0M%0S"`
echo 'naughty.notify({ title = "Recording in progress", icon = "/home/master-p/.config/awesome/icons/comicdee/media-record.png",timeout = 2 })' | awesome-client
ffmpeg -f x11grab -s wxga -r 60 -i :0.0 -qscale 0 ~/ScreenRecords/record-$DATE.mp4
echo 'naughty.notify({ title = "Record saved to ~/ScreenRecords/", icon = "/home/master-p/.config/awesome/icons/comicdee/media-arrow.png",timeout = 2 })' | awesome-client
