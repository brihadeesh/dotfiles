#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# LANG=en_GB.UTF-8
# LC_ALL=C
LC_ALL=en_US.UTF-8
# export LANG
export LC_ALL

# my shitty scripts + pip binaries
export PATH=$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.local/share/yabridge

# dotbare
# source ~/.dotbare/dotbare.plugin.bash
# set environment variable so that dotbare knows where to look for git information.
# export DOTBARE_DIR="$HOME/.cfg/.git"
# export DOTBARE_TREE="$HOME/.cfg"

# set a terminal so I don't have to do it each time for each wm
export TERMINAL=foot

# wayland native firefox?
# enable for wayland
export MOZ_ENABLE_WAYLAND=1
# ignore
## export GDK_BACKEND=wayland

# enable keychain for ssh-keys (prevents asking for passphrase each time)
# only for a wm-only setup without display manager
# eval `keychain --agents ssh --eval .ssh/id_ed25519_{github,srht,gitlab}`


# # autostart wayland?
# this bit doesn't seem to be nexessary (was for sway I think)
if test -z "${XDG_RUNTIME_DIR}"; then
    export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
    if ! test -d "${XDG_RUNTIME_DIR}"; then
	mkdir ${XDG_RUNTIME_DIR}
 	chmod 0700 "${XDG_RUNTIME_DIR}"
    fi
fi

# video accel for xorg
# export LIBVA_DRIVER_NAME=iHD

# audio server
pipewire &
pipewire-pulse &

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then

# autostart X at login on TTY1
# older version / use outside this `if' section
# if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/ttyv0 ]]; then exec startx; fi
    # startx

    # wayland
    # dbus-launch --exit-with-session sway;
    # fix for screensharing see: https://www.reddit.com/r/voidlinux/comments/1008a8n/issue_with_sharing_screen_via_chromium_on_wayland/jdhk7b1/
    dbus-run-session sway $@

    # dbus-run-session cagebreak

    # dbus-run-session hikari; ## NOTE: possibly deprecated dbus command for `dbus-launch`
    # dbus-launch --exit-with-session hikari;
    # XKB_DEFAULT_OPTIONS="ctrl:none,caps:ctrl_modifier" dbus-run-session river;
    # for when it's packaged, I guess
    # dbus-run-session cagebreak; ## NOTE: possibly deprecated dbus command for `dbus-launch`
    # dbus-launch --exit-with-session cagebreak;
fi
