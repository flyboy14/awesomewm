#!/bin/bash

FROM="$1"
TO="$2"
WORDS="`xsel -o`"
OUTPUT=`translate $FROM $TO $WORDS`
#OUTPUT=`trans -b -s $FROM -t $TO $WORDS`
echo "naughty.notify({text='"$OUTPUT"', timeout=0})"| awesome-client

