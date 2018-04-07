#!/bin/bash
LOCK=~/.i3/data/"$(hostname)"_locker.lck

locker() {
	case "$(hostname)" in
		Desktop)
			i3lock -n -i ~/.wallpaper/waluigi/too_bad_waluigi_time_1920x1080_lock.png
			;;
		ASUS|Toshiba)
			i3lock -n -i ~/.wallpaper/ftl/kestrel_by_andrewcolunga_1366x768.png
			;;
		*)
			i3lock -n -c ff00ff
			;;
	esac
}

if ! pgrep -x i3lock; then
	if ! [[ -f $LOCK ]]; then
		touch $LOCK
		locker

		sleep 1

		rm $LOCK
	fi
fi
