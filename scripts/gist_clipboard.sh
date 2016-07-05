#!/bin/bash

OPEN="-c"
[ "$#" -gt 0 ] && OPEN="-o"
gist -f "gist$RANDOM$RANDOM" -P $OPEN
xclip -o| xclip -selection clipboard
