#!/bin/bash
date > /tmp/arch_iso_date.txt
wget --quiet 'https://www.archlinux.org/download/' -O /tmp/arch_download.html

DATE=$(cat /tmp/arch_download.html | grep 'Current Release' | grep -Po '\d{4}(\.\d\d){2}')
for i in $(deluge-console info | grep -Po '^Name: archlinux-\d{4}(\.\d\d){2}-x86_64\.iso' | cut -c7-); do
	if ! [[ $i =~ $DATE ]]; then
		echo "$i: Deleting"
		deluge-console rm $i
	fi
done

echo "$DATE: Adding"
deluge-console add "$(cat /tmp/arch_download.html | grep -o '<li><a href="magnet:?xt=[^"]*' | cut -c14- | perl -pe 's/&amp;/&/g')"
echo "$DATE: Resuming"
deluge-console resume archlinux-$DATE
