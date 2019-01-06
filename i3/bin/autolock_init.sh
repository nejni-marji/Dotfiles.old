#!/bin/bash
# Show help dialogue, which isn't actually very clear at all.
[[ $1 =~ help|\-h|\?|man ]] && echo 'Usage: autolock_init.sh [LOCKER [SCREEN [NOTIFY]]]'
[[ $1 =~ help|\-h|\?|man ]] && exit

# If the lockfile is present at initialization, remove it.
LOCK=~/.i3/data/"$(hostname)"_locker.lck
[[ -f $LOCK ]] && rm -v $LOCK

# Set up variables.
[[ -z $1 ]] && LOCKER=30  || LOCKER=$1 # 30 minutes until lock
[[ -z $2 ]] && SCREEN=60  || SCREEN=$2 # 60 seconds from screen blank to lock
[[ -z $3 ]] && NOTIFY=120 || NOTIFY=$3 # 120 seconds from notify to lock
DELAY=$((60*$LOCKER-$SCREEN))          # 30 minutes - 60 seconds until screen blanking

# Overall, the defaults here are:
# 28 minutes until notify
# 29 minutes until screen blank
# 30 minutes until lock

# Print arguments for the record.
#echo -e "L: $LOCKER\tB: $SCREEN\tN: $NOTIFY"

# Get rid of any existing instances.
pkill xautolock
# I think this waits so that the previous pkill statement can't accidentally
# kill the following xautolock statement.
sleep 1

#	-detectsleep \
xautolock \
	-time $LOCKER \
	-locker '~/.i3/bin/autolock_locker.sh' \
	-notify $NOTIFY \
	-notifier "~/.i3/bin/autolock_notify.sh $NOTIFY" \
	&

# Print the xautolock instance.
#pgrep -ax xautolock

# Set DPMS and screensaver.
xset dpms $DELAY $DELAY $DELAY

# Print xset options.
xset s $DELAY $DELAY
#xset q | grep -A1 ^DPMS | tail -n1
#xset q | grep -A2 ^Screen\ Saver | tail -n1

#notify-send -a 'xautolock' 'Autolock initialized' "L: $LOCKER\tB: $SCREEN\tN: $NOTIFY"
