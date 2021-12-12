#!/usr/bin/env bash
# set -euo pipefail


## Echo battery status at regular intevals
while :; do
    # Battery Percentage
    BAT_PERC=$(cat /sys/class/power_supply/BAT1/capacity)

    # Battery Charging State
    BAT_STATE=$(cat /sys/class/power_supply/BAT1/status)

    # Master Volume
    # VOL=$(amixer scontents | awk 'NR==5 {print $4}')
    # MUTE_STATE=$(amixer scontents | awk 'NR==5 {print $6}')

    # Spotfiy Currently Playing Song and Artist
    #SPOT_INFO=$(python /home/isaac/.scripts/polybar-spotify/spotify_status.py -f '{artist}: {song}' -t 50)

    # Print Variables
    echo "$BAT_STATE $BAT_PERC%"
    sleep 30
done

exit 0
