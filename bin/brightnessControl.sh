#!/bin/bash

# You can call this script like this:
# $./backlightControl.sh up
# $./backlightControl.sh down
# $./backlightControl.sh mute

function get_backlight {
	xbacklight -get | cut -d '.' -f 1
}

function is_minimum {
	xbacklight -get | cut -d '.' -f 1 -le 20 
}

function send_notification {
	DIR=`dirname "$0"`
	backlight=`get_backlight`

	# Send the notification
	notify-send.sh "Backlight:" "$backlight%" -t 2000 --replace=555

}

function send_min_notif {
	DIR=`dirname "$0"`
	backlight=`get_backlight`

	#send notification
	notify-send.sh "Backlight:" "Set to mimimum" -t 2000 --replace=555
}

case $1 in
    up)
	# Up the backlight (+ 5%)
	xbacklight -inc 5% > /dev/null
	send_notification
	;;
    down)
	    if ((is_minimum)); then
		    send_min_notif
	    else
		    xbacklight -dec 5% > /dev/null
		    send_notification
	    fi
	;;
    min) 
	    if ((is_minimum)); then
		    send_min_notif
	    else
		    xbacklight -set 20% > /dev/null
		    send_min_notif
	    fi
	;;
esac

