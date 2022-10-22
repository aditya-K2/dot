#!/bin/sh

batteryPercentage=$(cat /sys/class/power_supply/BAT0/capacity)
printf " ^c$YELLOW_COLOR^  $batteryPercentage"
