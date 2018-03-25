#!/bin/bash
if [[ $(pactl list sinks short | wc -l) == 1 ]]; then
	SINK="$(pactl list sinks short | cut -f1)"
else
	echo Error >&2
	exit 1
fi
get_volume() {
	V_COUNT=$(pactl list sinks | grep -E '^\s*Volume:' | grep -Po '\d+%' | wc -l)
	VOLUMES=$(pactl list sinks | grep -E '^\s*Volume:' | grep -Po '\d+%')
	if [[ "$V_COUNT" == 1 ]]; then
		echo $VOLUMES
	else
		LV=$(echo $VOLUMES | awk '{print $1}')
		RV=$(echo $VOLUMES | awk '{print $2}')
		if [[ "$LV" == "$RV" ]]; then
			export VOLUME="$LV"
		else
			export VOLUME="$LV,$RV"
		fi
	fi
}

if [[ -z "$1" ]]; then
	get_volume
	echo $VOLUME
elif [[ "$1" == "mute" ]]; then
	pactl set-sink-mute $SINK toggle
	if [[ "$2" == "notify" ]]; then
		MUTE="$(pactl list sinks | grep -P "^(Sink #$SINK|\sMute: )" | grep -Po '(?<=: ).*')"
		[[ "$MUTE" == "yes" ]] && notify-send -t 2000 -a PulseAudio Volume Muted
		[[ "$MUTE" == "no"  ]] && notify-send -t 2000 -a PulseAudio Volume Unmuted
	fi
elif [[ "$1" == "show" ]]; then
	get_volume
	notify-send -t 2000 -a PulseAudio Volume "$VOLUME"
else
	pactl set-sink-volume $SINK "$1"
	if [[ "$2" == "notify" ]]; then
		get_volume
		notify-send -t 2000 -a PulseAudio -- Volume "$VOLUME ($1)"
	fi
fi
