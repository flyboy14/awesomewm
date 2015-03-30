#!/bin/bash
DATE=`/bin/date "+%0Y%0m%0d-%0k%0M%0S"`
notify-send -i ~/.config/awesome/icons/comicdee/media-record.png "Recording in progress"
ffmpeg -f x11grab -s wxga -r 60 -i :0.0 -qscale 0 ~/ScreenRecords/record-$DATE.mp4
notify-send -i ~/.config/awesome/icons/comicdee/media-arrow.png "Record saved to ~/ScreenRecords/"
