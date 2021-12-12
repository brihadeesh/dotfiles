#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -F --color=auto -X'
alias la='ls -FXa --color=auto'
# alias mocp='mocp -A -T transparent-background'
alias ncmpcpp='ncmpcpp -q'
alias scrot='scrot -q 100'

# PS1='[\u@\h \W]\$ '
# PS1='${PWD##*/} $ '
# PS1="\n  \w \n \\$\[$(tput sgr0)\] "

PS1='\n  \e[0;37m $(pp="$PWD/~" q=${pp/#"$HOME/"/} p=${q%?};((${#p}>19))&&echo "${p::5}...${p:(-15)}"||echo "$p") \n \$ \e[0m'

# [ -f ~/.fzf.bash ] && source ~/.fzf.bash

# bash completion for herbstclient
_herbstclient_complete() {
    local IFS=$'\n'
    # do not split at =, because BASH would not split at a '='.
    COMP_WORDBREAKS=${COMP_WORDBREAKS//=}
    COMPREPLY=(
        # just call the herbstclient complete .. but without herbstclient as argument
        $(herbstclient -q complete_shell "$((COMP_CWORD-1))" "${COMP_WORDS[@]:1}")
    )
}

complete -F _herbstclient_complete -o nospace herbstclient
_bspc() {
	local commands='node desktop monitor query rule wm subscribe config quit'

	local settings='external_rules_command status_prefix normal_border_color active_border_color focused_border_color presel_feedback_color border_width window_gap top_padding right_padding bottom_padding left_padding top_monocle_padding right_monocle_padding bottom_monocle_padding left_monocle_padding split_ratio automatic_scheme initial_polarity directional_focus_tightness borderless_monocle gapless_monocle single_monocle pointer_motion_interval pointer_modifier pointer_action1 pointer_action2 pointer_action3 click_to_focus swallow_first_click focus_follows_pointer pointer_follows_focus pointer_follows_monitor mapping_events_count ignore_ewmh_focus ignore_ewmh_fullscreen center_pseudo_tiled honor_size_hints remove_disabled_monitors remove_unplugged_monitors merge_overlapping_monitors'

	COMPREPLY=()

	if [[ $COMP_CWORD -ge 1 ]] ; then
		local current_word="${COMP_WORDS[COMP_CWORD]}"
		if [[ $COMP_CWORD -eq 1 ]] ; then
			COMPREPLY=( $(compgen -W "$commands" -- "$current_word") )
			return 0
		else
			local second_word=${COMP_WORDS[1]}
			case $second_word in
				config)
					if [[ $COMP_CWORD -eq 2 ]] ; then
						COMPREPLY=( $(compgen -W "$settings" -- "$current_word") )
						return 0
					fi
					;;
			esac
		fi
	fi
}

complete -F _bspc bspc


# pywal got github theme onlu; NOTE: comment out on switching
# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# (cat ~/.cache/wal/sequences &)

# vterm shell-side config, see: https://github.com/akermu/emacs-libvterm/tree/797357bf65952337627f2d0c594c2fef600aafae#shell-side-configuration
vterm_printf(){
    if [ -n "$TMUX" ]; then
        # Tell tmux to pass the escape sequences through
        # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

# vterm clear scrollback/screen
if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
    function clear(){
        vterm_printf "51;Evterm-clear-scrollback";
        tput clear;
    }
fi

# vim: set ft=sh:
