#!/usr/bin/env bash

# TODO: WTF to do here?!
BGR='#1E2231'

case "$1" in
	init)
		# nothing yet?
		hsetroot -solid '$BGR' &
		;;
	start)
                # usual suspects
		numlockx on &
		xbanish -i mod1 &
		xsetroot -cursor_name "Left_ptr" &

		# xclock???
		pkill -9 xclock
		xclock -strftime " %H:%M | %a %e %b " -geometry 120x18+5+15 -render \
		       -face "Isonorm:size=8" -fg '#ffffff' -bg $BGR &

		# redshift
		rdshft &
		;;
	stop)
                # do blah
                # or do function stop
		;;
esac
