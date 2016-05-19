#!/bin/sh

ACTION=`zenity --width=390 --height=200 --list --text="What's now?" --title="Logout" --column "I want to..." sleep reboot shutdown`

if [ -n "${ACTION}" ];then
 case $ACTION in
 sleep)
   slock |systemctl suspend
   ;;
 reboot)
   systemctl reboot
   ;;
 shutdown)
   systemctl poweroff
   ;;
 esac
fi
