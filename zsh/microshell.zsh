#!/usr/bin/env zsh

msh="$1"
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
