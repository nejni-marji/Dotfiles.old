#!/bin/bash

# This script is designed to update one text buffer from another.

verb="$2"

espeak() {
	if ! [[ $verb == v ]]; then return 0; fi
	/usr/bin/espeak "$@" >/dev/null 2>/dev/null &
}

display() {
	echo "Primary:   \"$(xsel -po)\""
	echo "Secondary: \"$(xsel -so)\""
	echo "Clipboard: \"$(xsel -bo)\""
}


case $1 in
	1|p|primary|m|mc|middleclick)
		espeak "primary to clipboard"
		xsel -po | xsel -pi
		xsel -po | xsel -bi
	;;
	2|s|secondary)
		espeak "no action"
	;;
	3|0|c|b|cb|clip|clipboard|ctrlv)
		espeak "clipboard to primary"
		xsel -bo | xsel -bi
		xsel -bo | xsel -pi
	;;
	k|keep)
		espeak "keep all buffers"
		xsel -po | xsel -pi
		xsel -so | xsel -si
		xsel -bo | xsel -bi
	;;
	x|C|cl|clear)
		espeak "clear all buffers"
		xsel -pc
		xsel -sc
		xsel -bc
	;;
	*)
		display
	;;
esac

if [[ $verb == v ]]; then
	display
fi
