#!/bin/bash

if [[ $1 == "fuzzy" ]]; then
	TIME="$(~/.i3/i3blocks.d/fuzzyclock | tail -n1 | rev | cut -c2- | rev)"
else
	TIME="$(date '+%T')"
fi

# "$(date '+%T')" \

notify-send \
-a i3wm \
-t 5000 \
"$TIME" \
"$(date '+%A, %B %-d')" \
