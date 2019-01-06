#!/bin/bash
LOCK=~/.i3/data/"$(hostname)"_locker.lck

[[ -z $1 ]] && NOTIFY=120 || NOTIFY=$1

if ! pgrep -afx "/bin/bash $HOME/.i3/bin/set_lockscreen.sh"; then
	if ! [[ -f $LOCK ]]; then
		notify-send -a xautolock \
		"Idling Detected" "Computer will lock in $(($NOTIFY/60)) minutes"
	fi
fi
