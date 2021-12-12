# autostart X at login on TTY1 
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
