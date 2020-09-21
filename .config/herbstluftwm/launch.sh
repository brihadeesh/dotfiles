#!/usr/bin/env bash
# ~/.config/bspwm/launch.sh

# Terminate already running bar instances
# killall -q polybar
pkill -x polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# add padding
# mon=$(herbstclient list_monitors | cut -d: -f1)
herbstclient pad 0 18 0 0 0

# Launch bar
polybar -q -c ~/.config/polybar/config hlwm &

#notify-send "welcome to herbstluftwm" &
