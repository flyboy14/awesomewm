#!/bin/bash
notify-send -i /usr/share/icons/buuf-icon-theme/48x48/Zimages/book-dictionary.png "$(xsel -o)" "$(wget -U "Mozilla/5.0" -qO - "http://translate.google.com/translate_a/t?client=t&text=$(xsel -o | sed "s/[\"'<>]//g")&sl=auto&tl=ru" | sed 's/\[\[\[\"//' | cut -d \" -f 1)"
