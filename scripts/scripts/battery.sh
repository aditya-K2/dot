#!/bin/sh

batteryPercentage=$(cat /sys/class/power_supply/BAT0/capacity)
NFILE="$HOME/suckless/scripts/nfile"
minValue=20

[[ $batteryPercentage -lt $minValue ]] && ! [[ -e "$NFILE" ]] && touch "$NFILE" && notify-send -u critical Low\ Battery! Please\ Plugin\ The\ Charge

! [[ $batteryPercentage -lt $minValue ]] && rm "$NFILE"

printf " ^c$YELLOW_COLOR^  $batteryPercentage"
