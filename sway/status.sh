#!/bin/sh

date_formatted=$(date +'%Y-%m-%d %H:%M')
battery_status=$(cat /sys/class/power_supply/BAT0/capacity)

echo $battery_status 🔋 $date_formatted
