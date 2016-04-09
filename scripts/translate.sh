#!/bin/bash
if [[ $# -eq 3 ]]; then
  WORDS="$3"
else
  WORDS="`xsel -o`"
fi
FROM="$1"
TO="$2"
OUTPUT=`translate $FROM $TO $WORDS`
#OUTPUT=`trans -b -s $FROM -t $TO $WORDS`
echo "show_smth(nil, '"$OUTPUT"', '"$HOME/.config/awesome/icons/comicdee/translate.svg"', 0)"| awesome-client

