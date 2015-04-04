#!/bin/bash
#notify-send -i $HOME/.config/awesome/icons/comicdee/translate.svg "$(xsel -o)" "$(wget -U "Mozilla/5.0" -qO - "http://translate.google.com/translate_a/t?client=t&text=$(xsel -o | sed "s/[\"'<>]//g")&sl=auto&tl=ru" | sed 's/\[\[\[\"//' | cut -d \" -f 1)"
INPUT=$(xsel -o)
OUTPUT=$(wget -U "Mozilla/5.0" -qO - "http://translate.google.com/translate_a/t?client=t&text=$(xsel -o | sed "s/[\"'<>]//g")&sl=auto&tl=ru" | sed 's/\[\[\[\"//' | cut -d \" -f 1)
echo 'show_smth("'$INPUT'", "'$OUTPUT'", "'$HOME/.config/awesome/icons/comicdee/translate.svg'", 3.5)' | awesome-client
