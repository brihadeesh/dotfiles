#!/bin/bash

#======~===~==============~===========~==
# GEOMETRY
#==~==========~=========~=============~~=
monitor=${1:-0}
geometry=( $(herbstclient monitor_rect "$monitor") )
if [ -z "$geometry" ] ;then
    echo "Invalid monitor $monitor"
    exit 1
fi
# geometry has the format: WxH+X+Y
x=${geometry[0]}
y=${geometry[1]}
width=${geometry[2]}
height=16
# font="-jmk-neep-medium-r-normal--10-80-75-75-c-50-iso8859-1"
font="-windows-montecarlo-medium-r-normal--11-110-72-72-c-60-microsoft-cp1252"

sep="^fg(#000000)^ro(1x$height)^fg()"


#======~===~==============~===========~==
# COLORS
#==~==========~=========~=============~~=

# get xresource colors
# read xresource colors to array "xrdb"
xrdb=( $(xrdb -query | grep -P "color[0-9]*:" | sort | cut -f 2-) )

# `sort` doesn't quite sort ascending, it sorts "0, 10, 11, 12, ..., 1, 2, 3, ...", so we need to fix.
# while we're at it, we might as well use proper names.

# define array "color" (actually a hash table)
declare -A color

# need this to get the values from xrdb one by one
index=0

# loop over color names
for name in black brightgreen brightyellow brightblue brightmagenta brightcyan brightwhite red green yellow blue magenta cyan white grey brightred; do
	# assign color value from array xrdb to hash "color"
	color[${name}]=${xrdb[$index]}
	# increase "index" by one, so we get the next color value for the next iteration
	((index++))
done

bgcolor='#0f0e0f'

separator_color='#000000'

hint_color_separator='#202020'

tag_active_color_fg='#151515'
tag_active_color_bg=${color["yellow"]}
tag_active_color_separator=${color["brightyellow"]}
# tag_active_color_separator='#ffdf7f'
tag_populated_color_fg='#efefef'
tag_populated_color_bg='#202020'
tag_populated_color_separator='#303030'
tag_notice_color_fg='#efefef'
tag_notice_color_bg=${color["red"]}
tag_notice_color_separator=${color["brightred"]}

#======~===~==============~===========~==
# ICONS
#==~==========~=========~=============~~=
iconpath=${XDG_CONFIG_HOME}/stumpwm/dzen/icons
function icon() {
	echo -n "^fg(#000000)^ro(1x$height)^fg()^bg(${color[${2}]})^fg(#151515) ^i(${iconpath}/${1}.xbm) ^fg(#000000)^ro(1x$height)^fg()^bg()"
}

#======~===~==============~===========~==
# MAIL
#==~==========~=========~=============~~=
gmaildir='/mnt/daten/Mail/Gmail/INBOX/new'
maildir='/mnt/daten/Mail/Mail/INBOX/new'

function mailcount() {
	count=0
	if [[ ! -n $(ls ${1}) ]]; then
		echo -n "0"
	else
		count=$(ls -1 ${1} | wc -l)
		echo -n ${count}
	fi
}

function mail() {
	echo -n $(icon mail blue) $(mailcount ${gmaildir}) $(mailcount ${maildir})
}

#======~===~==============~===========~==
# IRSSI
#==~==========~=========~=============~~=
irssilog=${XDG_DATA_HOME}/log/irssi/hilights.log
function irssi() {
	if [[ -f ${irssilog} ]]; then
		lastline=$(tail -n1 ${irssilog})
		echo -n $(icon balloon red) $(echo -n ${lastline} | cut -d " " -f -3)
	fi
}
#======~===~==============~===========~==
# CPU
#==~==========~=========~=============~~=
function temperature() {
	cpu=$(sensors | grep "Core" | cut -b 16-19)
	echo -n $(icon temp yellow) ${cpu}
}

#======~===~==============~===========~==
# MPD
#==~==========~=========~=============~~=
function m() {
	mpc -f %${1}% current | sed 's/ä/ae/g' | sed 's/ö/oe/g' | sed 's/ü/ue/g'
}
function nowplaying() {
	echo -n "$(icon note1 magenta) $(m title) ^fg(#909090)by^fg() $(m artist) ^fg(#909090)on^fg() $(m album)"
}

#======~===~==============~===========~==
# GET TO WORK
#==~==========~=========~=============~~=
function uniq_linebuffered() {
	awk '$0 != l { print ; l=$0 ; fflush(); }' "$@"
}

herbstclient pad $monitor $height
{
   # events:
   mpc idleloop player &
	while true ; do
		date +'date ^fg(#efefef) %H:%M^fg(#909090), %Y-%m-^fg(#efefef)%d'
		sleep 1 || break
	done > >(uniq_linebuffered)  &
	childpid=$!
	herbstclient --idle
	kill $childpid
} 2> /dev/null | {
	TAGS=( $(herbstclient tag_status $monitor) )
	date=""
	while true ; do
		bordercolor="#000000"
		hintcolor="#101010"

		# draw tags
		for i in "${TAGS[@]}" ; do
			case ${i:0:1} in
				'#')
					echo -n "^fg($tag_active_color_separator)^ro(1x$height)^fg()^bg($tag_active_color_bg)^fg($tag_active_color_fg)" ;;
				'+')
					echo -n "^fg()^ro(1x$height)^fg()^bg(#9CA668)^fg(#141414)";;
				':')
					echo -n "^fg($tag_populated_color_separator)^ro(1x$height)^fg()^bg($tag_populated_color_bg)^fg($tag_populated_color_fg)";;
				'!')
					echo -n "^fg($tag_notice_color_separator)^ro(1x$height)^fg()^bg($tag_notice_color_bg)^fg($tag_notice_color_fg)";;
				*)
					echo -n "^fg(#252525)^ro(1x$height)^fg()^bg()^fg()";;
			esac
			echo -n "^ca(1,herbstclient focus_monitor $monitor && "'herbstclient use "'${i:1}'") '"${i:1} ^ca()"
			echo -n "^fg($separator_color)^ro(1x$height)^fg()"
		done
		echo -n "^fg(#252525)^ro(1x$height)^fg()"
		echo -n "^bg()^p(_CENTER)"

		# small adjustments
		right=""
		for func in nowplaying temperature mail irssi; do
			right="${right} $(${func})"
		done
		right="${right} ^bg($hintcolor)$(icon clock2 green) $date"
		right_text_only=$(echo -n "$right"|sed 's.\^[^(]*([^)]*)..g')

		# get width of right aligned text.. and add some space..
		width=$(textwidth "$font" "$right_text_only              ")
		echo -n "^p(_RIGHT)^p(-$width)$right"
		echo

		# wait for next event
		read line || break
		cmd=( $line )

		# find out event origin
		case "${cmd[0]}" in
			tag*)
				#echo "reseting tags" >&2
				TAGS=( $(herbstclient tag_status $monitor) );;
			date)
				#echo "reseting date" >&2
				date="${cmd[@]:1}";;
			quit_panel)
				exit;;
			reload)
				exit;;
		esac
	done
} 2> /dev/null | dzen2 -w $width -x $x -y $y -fn "$font" -h $height \
	-ta l -bg "$bgcolor" -fg '#efefef'

