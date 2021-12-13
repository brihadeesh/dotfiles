#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# LANG=en_GB.UTF-8
# LC_ALL=C
LC_ALL=C.UTF-8
# export LANG
export LC_ALL

# my shitty scripts + pip binaries
export PATH=$PATH:$HOME/bin:$HOME/.dotbare

# dotbare
# source ~/.dotbare/dotbare.plugin.bash
# set environment variable so that dotbare knows where to look for git information.
# export DOTBARE_DIR="$HOME/.cfg/.git"
# export DOTBARE_TREE="$HOME/.cfg"

# set a terminal so I don't have to do it each time for each wm
export TERMINAL=alacritty

# wayland native firefox?
export MOZ_ENABLE_WAYLAND=1
# export GDK_BACKEND=wayland

# autostart X at login on TTY1
# if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/ttyv0 ]]; then exec startx; fi

# # autostart wayland?
# this bit doesn't seem to be nexessary (was for sway I think)
if test -z "${XDG_RUNTIME_DIR}"; then
    export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
    if ! test -d "${XDG_RUNTIME_DIR}"; then
	mkdir ${XDG_RUNTIME_DIR}
 	chmod 0700 "${XDG_RUNTIME_DIR}"
    fi
fi
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/ttyv0 ]]; then
	exec sway;
	# exec hikari;
fi
