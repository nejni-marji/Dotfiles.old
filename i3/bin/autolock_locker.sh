#!/bin/bash
LOCK=~/.i3/data/"$(hostname)"_locker.lck

# This utilizes the lockfile to prevent i3lock from running on top of itself.
if ! pgrep -afx "/bin/bash $HOME/.i3/bin/set_lockscreen.sh"; then
	if ! [[ -f $LOCK ]]; then
		touch $LOCK
		~/.i3/bin/set_lockscreen.sh

		# I don't know why this is here, but I'll keep it.
		sleep 1

		rm $LOCK
	fi
fi
