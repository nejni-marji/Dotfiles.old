#!/bin/bash

# This script is intended for personal use, so that I can quickly deploy my
# dotfiles on new installs.
cat << EOM
# This script is a massive hack, but the point of it is to automatically load
# configurations from dynami3.d/ into dynami3/, pathwise. The script will not
# run on its own. You should verify that the output is sane, first. Then,
# you must pass it to eval or pipe it into a shell.

EOM

for i in $(find dynami3.d -type f); do

	echo -n "ln -sf "
	echo $i | perl -pe 's#[^/]+/#../#g' | perl -pe 's#/[^/]+$##'
	echo -n "/$i "
	echo "$i" | perl -pe 's#^dynami3\.d#dynami3#'

done
