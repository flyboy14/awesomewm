#!/bin/bash
INPUT=$(xsel -o)
OUTPUT=$(pytranslate -f ru -t en $INPUT)
echo 'show_smth("'$INPUT'", "'$OUTPUT'", "'$HOME/.config/awesome/icons/comicdee/translate.svg'", 0)' | awesome-client
