#!/bin/bash

#
# This file is VERY important.
# It is intended to be an all-purpose controller for everything i3.
# This includes all autostart and autoshutdown mechanics.
#

init-desktop() {
	{}
#	xrandr --output DVI-D-0 --primary
#	~/bin/m570_sensitivity.sh .15 1
#	setxkbmap -layout us -variant dvorak
}

init-laptop() {
	xrandr --output LVDS-1 --primary

	# touchpad
	synclient TapButton1=1
	synclient TapButton2=3
	synclient TapButton3=2
	synclient CircularScrolling=1
	synclient CircScrollTrigger=1
}

init-generic() {
	xrdb -load ~/.Xresources
	# run xmodmap again if it fails
	xmodmap ~/.xmodmaprc || \
	xmodmap ~/.xmodmaprc
#	xset m 7/2 4
#	xset -b

	# This block is required to make Bluetooth work. It's either due to bad
	# module loading or permissions, I think.
#	{ pulseaudio --kill; sleep 1; pulseaudio --start; } &
}

exit-generic() {
	i3-msg exit
	exit
}

start-apps() {
#	redshift -O 4500
#	{ redshift-gtk & }
	compton -b
	{ dunst & }
}

stop-apps() {
	pkill -x redshift-gtk
	redshift -x
	pkill -x compton
	pkill -x dunst
}

if [[ $1 == exit ]]; then
	stop-apps
	exit-generic
fi

if [[ $1 == init ]]; then
	if [[ $(hostname) == ASUS ]]; then
		init-laptop
	fi
	init-generic
fi

if [[ $1 == edit ]]; then
	[[ $2 == preconf ]] && urxvt -e vim ~/.i3/preconfig
	[[ $2 == postconf ]] && urxvt -e vim ~/.i3/config
	[[ $2 == manager ]] && urxvt -e vim ~/.i3/manager.sh
	[[ $2 == vi3m ]] && urxvt -e vim ~/.i3/dynami3/plugins/vi3m/plugin.conf
	[[ $2 == vars ]] && urxvt -e vim ~/.i3/dynami3/plugins/vars/plugin.conf
fi

~/.i3/dynami3/dynami3.sh

stop-apps

# I don't know why this sleep has to be the way it is, but it does
# It's required for compton to load properly, though.
[[ $1 == restart ]] && i3-msg restart
[[ $1 == restart ]] && sleep 1
[[ $1 != restart ]] && i3-msg reload

start-apps

if [[ $1 == init ]]; then
	notify-send -t 500 -a 'i3wm' 'i3wm' 'Initialized'
fi
