#!/bin/zsh

SECDAY=$((60*60*24))
for curr in $(< ~/Documents/shit.txt tail -n+2); do
	echo -n "$(date --date=\@$curr '+%a, %b %-d')"
	if [[ -z $prev ]]; then
		prev=$curr
		echo ': ...'
	else
		curr=$(($curr-($curr%$SECDAY)))
		prev=$(($prev-($prev%$SECDAY)))
		diff=$(($curr-$prev))
		echo ": $(( $diff / $SECDAY + 1)) days"
		prev=$curr
	fi
done

