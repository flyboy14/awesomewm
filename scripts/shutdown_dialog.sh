#!/bin/sh

ACTION=`zenity --width=90 --height=200 --list --radiolist --text="Select logout action" --title="Logout" --column "Choice" --column "Action" TRUE Shutdown FALSE Reboot FALSE LockScreen FALSE Suspend`

if [ -n "${ACTION}" ];then
  case $ACTION in
  Shutdown)
    zenity --question --text "Are you sure you want to poweroff?" && poweroff
    ## или через ConsoleKit
    # dbus-send --system --dest=org.freedesktop.ConsoleKit.Manager \
    # /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop
    ;;
  Reboot)
    zenity --question --text "Are you sure you want to reboot?" && reboot
    ## или через ConsoleKit
    # dbus-send --system --dest=org.freedesktop.ConsoleKit.Manager \
    # /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Restart
    ;;
  Suspend)
    systemctl suspend
    #dbus-send --system --print-reply --dest=org.freedesktop.Hal \
    /org/freedesktop/Hal/devices/computer \
    #org.freedesktop.Hal.Device.SystemPowerManagement.Suspend int32:0
    # HAL является устаревшим, сейчас используются UPower и т.д.
    # dbus-send --system --dest=org.freedesktop.UPower /org/freedesktop/UPower 
org.freedesktop.UPower.Suspend
    ;;
  LockScreen)
    xscreensaver-command -lock
    # Или gnome-screensaver-command -l
    ;;
  esac
fi
