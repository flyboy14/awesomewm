#!/bin/bash
escrotum -s "$HOME/Pictures/Screenshots/screenshot-%0Y%0m%0d-%0k%0M%0S.png" && echo 'show_smth( nil, "Shot taken", iconsdir .. "/camera.svg", 2, nil, nil, nil, nil )' | awesome-client
