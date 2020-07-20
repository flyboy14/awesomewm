#!/bin/bash

if [[ "$1" == "ru" ]]; then 
	L_IN="en"
else
	L_IN="ru"
fi
RES=$(trans -b $L_IN:$1 "$2")
#notify-send -i ~/.config/awesome/icons/comicdee/translate.svg "$RES"
echo "$RES" | xclip -selection clipboard
echo "show_smth(\"$2\", \"$RES\", '/home/twiceaday/.config/awesome/icons/comicdee/translate.svg', 0, nil, nil, 'Sans 10')" | awesome-client
