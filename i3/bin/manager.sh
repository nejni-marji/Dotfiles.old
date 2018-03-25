#!/bin/bash
#
# ~/.i3/bin/manager.sh
#

init-desktop() {
	xrandr --output DVI-D-0 --primary
	~/bin/m570_sensitivity.sh .15 1
	setxkbmap -layout us
}

init-laptop() {
	xrandr --output LVDS1 --primary

	# touchpad
	synclient TapButton1=1
	synclient TapButton2=3
	synclient TapButton3=2
	synclient CircularScrolling=1
	synclient CircScrollTrigger=1

	# keyboard
	setxkbmap -layout us -variant dvorak

	# tray
	cbatticon -i symbolic -l 25 -r 10 -c 'systemctl suspend' &
}

init-generic() {
	xmodmap ~/.xmodmaprc
	xset m 7/2 4
	xset -b
	DELAY=29
	DELAY=$((60*$DELAY))
	xset dpms $DELAY $DELAY $DELAY

	~/.i3/bin/autolock_init.sh
	LOCK=~/.i3/data/"$(hostname)"_screenlock.lck
	touch $LOCK && rm $LOCK

	redshift -O 4500
	redshift-gtk &

	# This block is required to make Bluetooth work. It's either due to bad
	# module loading or permissions, I think.
	{ pulseaudio --kill; sleep 1; pulseaudio --start; } &
}

exit-generic() {
	redshift -x
	xbacklight -set 100
	i3-msg exit
	exit
}

reset-compton() {
	pgrep -x compton && pkill -x compton
	compton -b
}

if [[ $1 == init ]]; then
	[[ $(hostname) == Desktop ]] && init-desktop || init-laptop
	init-generic
fi

[[ $1 == exit ]] && exit-generic
if [[ $1 == edit ]]; then
	[[ $2 == main ]] && urxvt -e vim ~/.i3/preconfig
	[[ $2 == true ]] && urxvt -e vim ~/.i3/config
	[[ $2 == vi3m ]] && urxvt -e vim ~/.i3/dynami3/plugins/vi3m/plugin.conf
	[[ $2 == vars ]] && urxvt -e vim ~/.i3/dynami3/plugins/core/vars/plugin.conf
fi

~/.i3/dynami3/dynami3.sh

# I don't know why this sleep has to be the way it is, but it does
[[ $1 == restart ]] && i3-msg restart
[[ $1 == restart ]] && sleep .25
i3-msg reload

reset-compton

if [[ $1 == init ]]; then
	notify-send -t 500 -a 'i3wm' 'i3wm' 'Initialized'
fi
