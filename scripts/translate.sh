#!/bin/bash

if [[ "$1" == "ru" ]]; then 
	L_IN="en"
else
	L_IN="ru"
fi
RES="$(translate -s $L_IN -d $1 "$2" | grep "\[$1\]" | cut -d' ' -f2-)"
PRON="$(translate -s $L_IN -d $1 "$2" | grep "pron." | cut -d' ' -f2-)"
notify-send -i ~/.config/awesome/icons/comicdee/translate.svg "$RES" "($PRON)"
