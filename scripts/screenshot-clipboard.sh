#!/bin/bash
echo 'show_smth( nil, "Choose area or window", iconsdir .. "/screen-measure.svg", 2, nil, nil, nil, nil )' | awesome-client
escrotum -s -C && echo 'show_smth( nil, "Shot gonna be copied to clipboard (probably)", iconsdir .. "/camera.svg", 2, nil, nil, nil, nil )' | awesome-client
