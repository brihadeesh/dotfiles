#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

LC_ALL=C
export LC_ALL

# if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#   exec startx
# fi
# my shitty scripts + doomooomoom + pip executables
export PATH=$PATH:$HOME/bin:$HOME/.local/bin
# spicetify
# export SPICETIFY_INSTALL="/home/peregrinator/spicetify-cli"
# export PATH="$SPICETIFY_INSTALL:$PATH"


# autostart X at login on TTY1
# [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi

# set this directory fgs
export XDG_CONFIG_HOME="$HOME/.config"

