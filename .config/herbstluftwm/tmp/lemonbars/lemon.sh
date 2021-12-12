#!/bin/sh
#
# z3bra - (c) wtfpl 2014
# Fetch infos on your computer, and print them to stdout every second.

# Import colours from wal
. "${HOME}/.cache/wal/colors.sh"

norbg="#000000"
norfg="$color2"
selbg="#000000"
selfg="$color6"

clock() {
    date '+%Y-%m-%d %H:%M'
}

battery() {
    BATC=/sys/class/power_supply/BAT1/capacity
    BATS=/sys/class/power_supply/BAT1/status

    test "`cat $BATS`" = "Charging" && echo -n '+' || echo -n '-'

    sed -n p $BATC
}

cpuload() {
    LINE=`ps -eo pcpu | grep -vE '^\s*(0.0|%CPU)' |sed -n '1h;$!H;$g;s/\n/ +/gp'`
    bc <<< $LINE
}

tag() {
    #cur=`xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}'`
    #tot=`xprop -root _NET_NUMBER_OF_DESKTOPS | awk '{print $3}'`

    #cur =`herbstclient list_monitors | awk '{print $5}' | sed s/\"//g`
    #echo "$cur"

    while :; do
    wm=""
    #tags=( $(herbstclient tag_status $monitor) )
    IFS=$'\t' read -ra tags <<< "$(herbstclient tag_status $monitor)"
    for i in "${tags[@]}" ; do
            case ${i:0:1} in
                '#') # selected
                    fg=${selfg}
		    bg=${norbg}
		    echo " "
                    ;;
	        '+') # active on other mon
                    fg=${selfg}
		    bg=${norbg}
		    echo " "
                    ;;
                ':') # occupied
		    fg=${foreground}
		    bg=${norbg}
		    echo " "
                    ;;
                '!') # urgent
                    fg=${background}
		    bg=${foreground}
		    echo " "
		    ;;
                *)   # empty
                    fg=${norfg}
		    bg=${norbg}
		    echo " "
                    ;;
            esac
	    wm="$wm %{B$bg}%{F$fg} $(printf '%b') %{F-}%{B-}"
        done
	echo "A${wm}"
        sleep 0.1 || break
    done &
    while :; do
        echo "W$(tag)"
        echo "R$(battery) $(cpuload) $(clock)"
        sleep 1 || break
    done &

}

# This loop will fill a buffer with our infos, and output it to stdout.
while :; do
    buf=""
    buf="${buf} $(tag) | "
    buf="${buf} $(clock) | "
    buf="${buf} $(cpuload)% | "
    buf="${buf} $(battery)"

    echo $buf
    sleep 1 # The HUD will be updated every second
done
