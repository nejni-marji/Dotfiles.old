#!/bin/bash
[[ $1 =~ help|\-h|\?|man ]] && echo 'Usage: autolock_init.sh [LOCKER [SCREEN [NOTIFY]]]'
[[ $1 =~ help|\-h|\?|man ]] && exit
LOCK=~/.i3/data/"$(hostname)"_locker.lck
rm $LOCK

[[ -z $1 ]] && LOCKER=30  || LOCKER=$1
[[ -z $2 ]] && SCREEN=60  || SCREEN=$2
[[ -z $3 ]] && NOTIFY=120 || NOTIFY=$3
DELAY=$((60*$LOCKER-$SCREEN))

pgrep xautolock >/dev/null && pkill xautolock
sleep 1

xautolock \
	-detectsleep \
	-time $LOCKER \
	-locker '~/.i3/bin/autolock_locker.sh' \
	-notify $NOTIFY \
	-notifier "~/.i3/bin/autolock_notify.sh $NOTIFY" \
	&

pgrep -ax xautolock

xset dpms $DELAY $DELAY $DELAY
xset s $DELAY $DELAY
xset q | grep -A1 ^DPMS | tail -n1
xset q | grep -A2 ^Screen\ Saver | tail -n1
