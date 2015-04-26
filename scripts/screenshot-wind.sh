#!/bin/bash
DATE=`/bin/date "+%0Y%0m%0d-%0k%0M%0S"`
activeWinLine=$(xprop -root | grep "_NET_ACTIVE_WINDOW(WINDOW)")
activeWinId=${activeWinLine:40}
import -window "$activeWinId" "/home/master-p/Pictures/Screenshots/screenshot-$DATE.png"

