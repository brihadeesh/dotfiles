#!/bin/bash

# You can call this script like this:
# $./volumeControl.sh up
# $./volumeControl.sh down
# $./volumeControl.sh mute

function get_volume {
    #amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d ']' -f 1
    pactl get-sink-volume @DEFAULT_SINK@ | head -n 1 | awk '{print substr($5, 1, length($5)-1)}'
}

function is_mute {
    # amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
    pactl get-sink-mute @DEFAULT_SINK@
}

function send_notification {
    DIR=`dirname "$0"`
    volume=`get_volume`

# Send the notification
notify-send.sh "Volume:" "$volume" -t 2000 --replace=555

}

case $1 in
    up)
	# Set the volume on (if it was muted)
	# amixer set Master on > /dev/null
	# amixer sset Master 5%+ > /dev/null
	pactl set-sink-mute @DEFAULT_SINK@ 0
	# increase vol
	pactl set-sink-volume @DEFAULT_SINK@ +5%
	# send_notification
	;;
    down)
	# amixer set Master on > /dev/null
	# amixer sset Master 5%- > /dev/null
	pactl set-sink-mute @DEFAULT_SINK@ 0
	# decrease vol
	pactl set-sink-volume @DEFAULT_SINK@ -5%
	# send_notification
	;;
    mute)
    	# Toggle mute
	# amixer set Master 1+ toggle > /dev/null
	# if is_mute ; then
	# 	notify-send.sh "Volume:" "muted" -t 2000 --replace=555
	# else
	#     send_notification
	# fi

	pactl set-sink-mute @DEFAULT_SINK@ toggle
	notify-send.sh "$(is_mute)" -t 2000 --replace=555
	;;
esac
