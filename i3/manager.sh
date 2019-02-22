#!/bin/bash

#
# This file is VERY important.
# It is intended to be an all-purpose controller for everything i3.
# This includes all autostart and autoshutdown mechanics.
#

init-desktop() {
	xrandr --output DVI-D-0 --primary
	~/bin/m570_sensitivity.sh
}

init-laptop() {
	xrandr --output LVDS1 --primary

	# touchpad
	synclient TapButton1=1
	synclient TapButton2=3
	synclient TapButton3=2
	synclient CircularScrolling=1
	synclient CircScrollTrigger=1

	# tray
	pkill -x cbatticon
	{ cbatticon -i symbolic -l 25 -r 10 -c 'systemctl suspend' & }
}

init-generic() {
	xrdb -load ~/.Xresources

	# set keymap
	setxkbmap -layout us -variant dvorak
	xmodmap ~/.xmodmaprc

	xset m 7/2 4
	xset -b

	# This block is required to make Bluetooth work. It's either due to bad
	# module loading or permissions, I think.
#	{ { pulseaudio --kill; sleep 1; pulseaudio --start; } & }
}

exit-generic() {
	stop-apps
	redshift -x
	# set backlight to something?
	i3-msg exit
	exit
}

start-apps() {
	redshift -Po
	{ redshift -P & }
	# compton -b
	{ dunst & }
	~/.i3/bin/autolock_init.sh 30 300 600
}

stop-apps() {
	redshift -Po
	pkill -x redshift
	pkill -x compton
	pkill -x dunst
}

repair-compton() {
	for i in $(
		wmctrl -l | awk '{print $1}'
	); do
		xprop -id $i -remove _NET_WM_WINDOW_OPACITY;
	done
}



if [[ $1 == exit ]]; then
	stop-apps
	exit-generic
fi

if [[ $1 == init ]]; then
	if [[ $(hostname -d) == ASUS.localdomain ]]; then
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

[[ ( $1 == restart ) || ( $1 == init ) ]] && stop-apps

# I don't know why this sleep has to be the way it is, but it does
# It's required for compton to load properly, though.
[[ $1 == restart ]] && i3-msg restart
# [[ $1 == restart ]] && $do_apps && sleep 1
[[ $1 != restart ]] && i3-msg reload

[[ ( $1 == restart ) || ( $1 == init ) ]] && start-apps
repair-compton

if [[ $1 == init ]]; then
	notify-send -t 500 -a 'i3wm' 'i3wm' 'Initialized'
fi
