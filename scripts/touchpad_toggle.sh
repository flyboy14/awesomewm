#!/bin/bash

if [[ $(synclient -l | grep Touchpad | tr -d ' ' | cut -d'=' -f2) -eq 0 ]]; then
	synclient TouchpadOff=1
else
	synclient TouchpadOff=0
fi
