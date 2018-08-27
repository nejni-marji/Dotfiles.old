#!/usr/bin/env zsh

#
# microshell.zsh
#
# This file is meant to be sourced without argument:
# % source microshell.zsh
#
# The 'msh' command should start prefixing the $1 of the command to all new
# input lines in the shell. Why would you want this? Running a bunch of git
# commands in a row, or something like that. In order to escape this state,
# just hit Control+D (^D). Also, if you delete the prepended text (say, with
# ^W), then you can run other commands as normal.
#
### Sample shell session
#	~ % source microshell.zsh
#	Adding the 'msh' command
#	~ % msh git
#	~ % git
###

msh_arg=microshell_initialization_argument
this="$0"
if ! [[ $1 == $msh_arg ]]; then
	! [[ $1 == quiet ]] && echo "Adding the 'msh' command"
	msh() {
		source "$this" "$msh_arg" $1
	}
	return 0
fi

msh="$2"
[[ -z "$msh" ]] && return 0
prefix="$msh "

zle-line-init() {
	BUFFER="$prefix"
	CURSOR="$#prefix"
}

delete-zle-line-init() {
	BUFFER=""
	zle -D zle-line-init
	bindkey "^D" list-choices
}

zle -N zle-line-init
zle -N delete-zle-line-init
bindkey "^D" delete-zle-line-init
