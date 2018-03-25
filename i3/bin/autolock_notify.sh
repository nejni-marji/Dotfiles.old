#!/bin/bash
LOCK=~/.i3/data/"$(hostname)"_locker.lck

[[ -z $1 ]] && NOTIFY=120 || NOTIFY=$1

locknotify() {
	notify-send -a xautolock \
	"Idling Detected" "Computer will lock in $(($NOTIFY/60)) minutes"
}

if ! pgrep -x i3lock; then
	if ! [[ -f $LOCK ]]; then
		locknotify
	fi
fi
