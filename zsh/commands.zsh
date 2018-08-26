#!/bin/zsh

msh() {
	source ~/.zsh/microshell.zsh $1
}

cl() {
	local dir="$1"
	local dir="${dir:=$HOME}"
	if [[ -d "$dir" ]]; then
		cd "$dir" >/dev/null; ls
	elif [[ "$dir" = "-" ]]; then
		cd -; ls
	else
		echo "zsh: cl: $dir: Directory not found"
	fi
}

timer() {
	TIMER=$((60*$1))
	echo $TIMER
	while [[ $TIMER > 0 ]]; do
		sleep 1
		TIMER=$(($TIMER-1))
		echo $TIMER
	done
	echo -e '\a'
}

create-exe() {
	touch $1
	chmod u+x $1
}

create-sh() {
	echo '#!/bin/bash' > $1.sh
	chmod u+x $1.sh
}

create-py() {
	echo '#!/usr/bin/env python3' > $1.py
	chmod u+x $1.py
}

hidehist() {
	if [[ $1 == on ]]; then
		HISTFILE=/dev/null
	elif [[ $1 == off ]]; then
		HISTFILE=~/.zsh_history
	else
		if [[ $HISTFILE == "/dev/null" ]]; then
			echo 'H '
		else
			echo -n
		fi
	fi
}
