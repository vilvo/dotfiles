#!/bin/sh

date_formatted=$(date +'%Y-%m-%d %H:%M')
host=$(hostname)

# the default applies to desktop - always powered
battery_status="100"

if [[ $host = "blip" ]] || [[ $host = "carrie" ]]
then
    battery_status=$(cat /sys/class/power_supply/BAT0/capacity)
elif [[ $host = "blub" ]]
then
    battery_status=$(cat /sys/class/power_supply/macsmc-battery/capacity)
fi

echo $battery_status% 🔋 $date_formatted
