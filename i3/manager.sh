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
	case "$(hostname -d)" in
		ASUS.localdomain)
			init-laptop
		;;
		Desktop.localdomain)
			init-desktop
		;;
	esac
	init-generic
fi



if [[ $1 == edit ]]; then
	do_edit=true
	case $2 in
		preconf)
			target=~/.i3/preconfig
		;;
		postconf)
			target=~/.i3/config
		;;
		manager)
			target=~/.i3/manager.sh
		;;
		vi3m)
			target=~/.i3/dynami3/plugins/vi3m/plugin.conf
		;;
		vars)
			target=~/.i3/dynami3/plugins/vars/plugin.conf
		;;
		*)
			do_edit=false
		;;
	esac

	# There's an option to exit prematurely. This can prevent the execution of
	# heavier code in the event that we don't want to modify any files.
	if $do_edit; then
		if [[ $3 != exit ]]; then
			urxvt -e vim "$target"
		else
			urxvt -e vim -R "$target"
			exit
		fi
	fi
fi



# This should always be run, in order to update the i3 config.
~/.i3/dynami3/dynami3.sh



# If restarting apps is ever desired for edit, use these conditions.
# if [[ ( $1 == restart ) || ( $1 == init ) || ( $1 == edit ) ]]; then
	# if ! [[ ( $2 -eq no-apps ) || ( ( $1 -eq edit ) && ( $3 -eq no-apps ) ) ]]; then

# A better idea may be to have edit not restart apps by default, but allow $3
# to be used to request that to occur.
# I am not implementing this now.


# Determine whether or not we should restart apps.
do_apps=false
if [[ $1 == restart || $1 == init ]]; then
	if ! [[ $2 == no-apps ]]; then
		do_apps=true
	fi
fi



$do_apps && stop-apps

# I don't know why this sleep has to be the way it is, but it does
# It's required for compton to load properly, though.
[[ $1 == restart ]] && i3-msg restart
# [[ $1 == restart ]] && $do_apps && sleep 1
[[ $1 != restart ]] && i3-msg reload

$do_apps && start-apps
repair-compton

if [[ $1 == init ]]; then
	notify-send -t 500 -a 'i3wm' 'i3wm' 'Initialized'
fi
