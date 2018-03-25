#!/bin/zsh

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

ranger() {
	if [ -z "$RANGER_LEVEL" ]; then
		/usr/bin/ranger "$@"
	else
		exit
	fi
}

loop() {
	while true; do
		$@
		sleep 1
	done
}

testfont() {
	echo -e "\033]710;xft:$@\007"
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

randint() {
	python -c 'from random import randint; print(randint('$1','$2'))'
}

nenmaj_add() {
	telegram-cli -DWe "channel_invite $1 la_nenmaj_sampre"
	telegram-cli -We "chat_add_user $1 la_nenmaj_sampre"
}
