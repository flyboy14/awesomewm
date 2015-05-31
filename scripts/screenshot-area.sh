#!/bin/bash
DATE=`/bin/date "+%0Y%0m%0d-%0k%0M%0S"`
import "$HOME/Pictures/Screenshots/screenshot-$DATE.png"
sleep 1s&& echo 'show_smth( nil, "Shot taken", iconsdir .. "/camera.svg", 2, nil, nil, nil, nil )' | awesome-client
