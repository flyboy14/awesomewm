#!/bin/bash
if [[ $# -ne 1 ]]; then
  INPUT=$(xsel -o)
else
  INPUT=$1
fi
OUTPUT=$(pytranslate -f en -t ru $INPUT)
echo 'show_smth("'$INPUT'", "'$OUTPUT'", "'$HOME/.config/awesome/icons/comicdee/translate.svg'", 0)' | awesome-client
