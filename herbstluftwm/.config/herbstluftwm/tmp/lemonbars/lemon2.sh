# Format the Panel
herbstclient -i |
while read line; do

    case $line in
	window_title_changed*)
	    wnd_title=`echo $line | awk '{$1=$2=""; print $0}' | cut -c 1-40`
	    ;;
	focus_changed*)
	    wnd_title=`echo $line | awk '{$1=$2=""; print $0}' | cut -c 1-40`
	    ;;

	tag_changed*)
	    wm_infos=""
	    TAGS=( $(herbstclient tag_status $monitor) )
	    for i in "${TAGS[@]}" ; do
		if [[ $i != *8 ]]; then
		    case ${i:0:1} in
		# ...
		    esac
		    wm_infos="${wm_infos}%{F${FG}}${ICON}%{F-}"
		fi
		shift
	    done
	    ;;


	REFRESH_PANEL*BIG*)
	    mail_=$(~/.mutt/new_mail.sh 2> /dev/null)
	    t_="\ue015 "$(date +"%l:%M" | sed 's/ //')
	    batt_="  $(~/run/herbstluftwm/panel-scripts/battery.sh) "
    # ...
	    ;;


	REFRESH_PANEL*SMALL*)
	    wifi_=`~/run/herbstluftwm/panel-scripts/wireless.sh`

	    if [[ `mpc status | grep playing` != "" ]]; then
		mpc_=" \uE0EC "
	    else
		mpc_=""
	    fi
	    ;;
    esac

    echo -e  "format all your defined variables here"

done | lemonbar [your settings] 2> /dev/null | sh &


# Emit hooks to keep it updating
while true; do
    herbstclient emit_hook REFRESH_PANEL BIG
    for i in {1..10}; do
	herbstclient emit_hook REFRESH_PANEL SMALL
	sleep 3
    done
done &
