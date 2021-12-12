#!/bin/bash

# You can call this script like this:
# $./volumeControl.sh up
# $./volumeControl.sh down
# $./volumeControl.sh mute

function get_volume {
	amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d ']' -f 1
}

function is_mute {
    amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
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
	amixer set Master on > /dev/null
	# Up the volume (+ 5%)
	amixer sset Master 5%+ > /dev/null
	send_notification
	;;
    down)
	amixer set Master on > /dev/null
	amixer sset Master 5%- > /dev/null
	send_notification
	;;
    mute)
    	# Toggle mute
	amixer set Master 1+ toggle > /dev/null
	if is_mute ; then
		notify-send.sh "Volume:" "muted" -t 2000 --replace=555 
	else
	    send_notification
	fi
	;;
esac

