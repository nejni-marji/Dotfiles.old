#!/bin/bash
dy_dir="$(dirname "${BASH_SOURCE[0]}")"
lock_dir="$dy_dir/data/locks"
[[ -z $2 ]] && exit
lock="$lock_dir/$2.lck"

case $1 in
	get)
		! [[ -f $lock ]]
	;;
	set)
		case $3 in
			1|on|enable)
				touch $lock
			;;
			0|off|disable)
				touch $lock; rm $lock
			;;
			*)
				[[ -f $lock ]] && rm $lock || touch $lock
			;;
		esac
	;;
esac
