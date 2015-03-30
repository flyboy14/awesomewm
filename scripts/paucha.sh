#!/bin/bash

RANGE=10
number=$RANDOM
let "number %= $RANGE"

pkill notisy-osd

if [ "$number" == "1" ]; then
 notify-send '//\(_-.-_)/\\' 'Go do that shit.'
elif [ "$number" == "2" ]; then
 notify-send '//\(_0.0_)/\\' 'Stop clicking at me.'
elif [ "$number" == "3" ]; then
 notify-send '//\(x.x)/\\' 'You are killing me... With your curiousity.'
elif [ "$number" == "4" ]; then
 notify-send '//\(o.0_)/\\' 'Why are you still doing it, human?'
elif [ "$number" == "5" ]; then
 notify-send '//\(_o.o_)/\\' 'Stop that crap, human being!'
elif [ "$number" == "6" ]; then
 notify-send '//\(-..-)/\\' 'Could you, please, stop?'
elif [ "$number" == "7" ]; then
 notify-send '//\(o_o)/\\' 'Easy enough to mock little spider?..'
else
 notify-send '//\(^_^)/\\' 'I almost hate you'
fi
