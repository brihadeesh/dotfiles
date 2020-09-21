#! /bin/sh

# Panel settings
PANEL_FIFO="$HOME/.cache/lemon/fifo"
PANEL_HEIGHT="16"

# Panel colors, from bspwm examples
COLOR_FOREGROUND='#FFA3A6AB'
COLOR_BACKGROUND='#FF34322E'
COLOR_ACTIVE_MONITOR_FG='#FF34322E'
COLOR_ACTIVE_MONITOR_BG='#FF58C5F1'
COLOR_INACTIVE_MONITOR_FG='#FF58C5F1'
COLOR_INACTIVE_MONITOR_BG='#FF34322E'
COLOR_FOCUSED_OCCUPIED_FG='#FFF6F9FF'
COLOR_FOCUSED_OCCUPIED_BG='#FF5C5955'
COLOR_FOCUSED_FREE_FG='#FFF6F9FF'
COLOR_FOCUSED_FREE_BG='#FF6D561C'
COLOR_FOCUSED_URGENT_FG='#FF34322E'
COLOR_FOCUSED_URGENT_BG='#FFF9A299'
COLOR_OCCUPIED_FG='#FFA3A6AB'
COLOR_OCCUPIED_BG='#FF34322E'
COLOR_FREE_FG='#FF6F7277'
COLOR_FREE_BG='#FF34322E'
COLOR_URGENT_FG='#FFF9A299'
COLOR_URGENT_BG='#FF34322E'
COLOR_LAYOUT_FG='#FFA3A6AB'
COLOR_LAYOUT_BG='#FF34322E'
COLOR_TITLE_FG='#FFA3A6AB'
COLOR_TITLE_BG='#FF34322E'
COLOR_STATUS_FG='#FFA3A6AB'
COLOR_STATUS_BG='#FF34322E'

# Kill any open lemon processes.
while [ $(pgrep -cx lemon3.sh) -gt 1 ] ; do
	pkill -ox -9 lemon3.sh
done

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

# Set the fifo file
[ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
mkfifo "$PANEL_FIFO"

# Make room for the panel
# bspc config top_padding $PANEL_HEIGHT
# Continuosly print bspc events to fifo file
# bspc control --subscribe > "$PANEL_FIFO" &

# Continuously print formatted date
function clock {
    while true; do
        date +"S%d/%m %H:%M"
        sleep 1
    done
}

clock > "$PANEL_FIFO" &

# Function that reads the fifo file and outputs values to stdout (for lemonbar)
function panel_bar {
    while read line < $PANEL_FIFO; do
        case $line in
            S*)
            date="${line#?}"
        esac

        fmt="%{r}${date}"

        printf "%s\n" "$fmt"
    done
}

# Invoke and pipe to the panel
panel_bar | lemonbar -g x$PANEL_HEIGHT -F "$COLOR_FOREGROUND" -B "$COLOR_BACKGROUND" &

wait
