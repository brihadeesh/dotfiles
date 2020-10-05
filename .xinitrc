#!/bin/sh

# this file is executed when calling startx

# to start a different WM, set session="WM" below, or in console run:
#    startx ~/.xinitrc WM

# session to run if none passed as first arg ($1)
session="${1:-hlwm}"

# set environment wm for use in scripts
export WM="$session"

# default arch xinit scripts
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*.sh; do
        [ -x "$f" ] && . "$f"
    done
fi

# user init scripts and settings
[ -f /etc/X11/xinit/.Xmodmap ] && xmodmap /etc/X11/xinit/.Xmodmap
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
[ -f ~/.xprofile ] && source ~/.xprofile

# display timeout and sleep
xset s 3600 3600
xset dpms 3600 3700 4000

# keyboard repeat rate
xset r rate 400 50
kbdrate -d 400 -r 50

# dbus
dbus-update-activation-environment --all
dbus-launch

# adding paths to font config???
# xset +fp /usr/share/fonts/envypn
# xset +fp /usr/share/fonts/spleen

## pywal restore last theme
#wal -R

## rebind caps-lock to ctrl
setxkbmap -option ctrl:nocaps

# do NOT put commands below the exec lines
case $session in

    spectrwm)
	exec spectrwm ;;

    dwm)
        ~/.dwm/startdwm.sh ;;

    bspwm)
	exec bspwm ;;

    hlwm)
        exec herbstluftwm --locked ;;

    cwm)
	~/.config/cwm/autostart &
	exec cwm ;;

    e16)
        exec e16 ;;

    exwm)
        # Disable access control for the current user.
        xhost +SI:localuser:$USER
        # Make Java applications aware this is a non-reparenting window manager.
        export _JAVA_AWT_WM_NONREPARENTING=1

        # Set default cursor.
        xsetroot -cursor_name left_ptr

        # Set keyboard repeat rate.
        # xset r rate 200 60

        # Uncomment the following block to use the exwm-xim module.
        #export XMODIFIERS=@im=exwm-xim
        #export GTK_IM_MODULE=xim
        #export QT_IM_MODULE=xim
        #export CLUTTER_IM_MODULE=xim

        # usually reqd stuff
        xbanish -i control &
        rdshft &
        picom -b

        # Finally start Emacs
        exec emacs ;;

    sowm)
        # redshift &
        # picom -b &
        # xsetroot -cursor_name left_ptr &
        # numlockx &
        # hsetroot -solid '#666666' &
        exec sowm ;;

    wmii)
	exec wmii ;;

    *)        exec "$session" # Unknown, try running it
esac
