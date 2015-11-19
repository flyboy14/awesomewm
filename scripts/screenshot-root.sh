#!/bin/bash
escrotum "$HOME/Pictures/Screenshots/screenshot-%0Y%0m%0d-%0k%0M%0S.png"
sleep 1s&& echo 'show_smth( nil, "Shot taken", iconsdir .. "/camera.svg", 2, nil, nil, nil, nil )' | awesome-client
