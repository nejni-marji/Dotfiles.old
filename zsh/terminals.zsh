#!/bin/zsh

title_command_ignore=(cd echo cl ls)

set_urxvt_title() {
	echo -ne "\033]0;$1\007"
}

set_urxvt_title_command() {
	if [[ $1 =~ \\\\ ]]; then
		set_urxvt_title "$USER@$HOST:$(echo -n $PWD | sed -e s#$HOME#~#) % ???"
		return 0
	fi
	CMD=$(echo "$1" | cut -d\  -f1)
	set_urxvt_title $CMD
	if [[ ${title_command_ignore[(r)$CMD]} != $CMD ]]; then
		set_urxvt_title "$USER@$HOST:$(echo -n $PWD | sed -e s#$HOME#~#) % $1"
	fi
}

set_urxvt_title_prompt() {
	set_urxvt_title "$USER@$HOST:$(echo -n $PWD | sed -e s#$HOME#~#)"
}

[[ $(hostname -d) == Kubuntu ]] && return 0

add-zsh-hook preexec set_urxvt_title_command
add-zsh-hook precmd set_urxvt_title_prompt
