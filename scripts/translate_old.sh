#!/bin/bash

if [[ "$1" == "ru" ]]; then 
	L_IN="en"
else
	L_IN="ru"
fi
RES="$(trans -b $L_IN:$1 "$2")"
#PRON="$(translate -s $L_IN -d $1 "$2" | grep "pron." | cut -d' ' -f2-)"
notify-send -i ~/.config/awesome/icons/comicdee/translate.svg "$RES"
