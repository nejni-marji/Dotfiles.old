#!/bin/zsh

alias p=pwds
pwds() {
	pwds_n=$1
}

pwds 3

pwds_status() {
	pwd | \
	perl -pe "s#^$HOME#~#" | \
	perl -pe 's#^~$#%B~%b#' | \
	perl -pe 's#(?<=/)([^/\n]+$)#%B\1%b#' | \
	perl -pe 's#(?<=/)([^/]{'"$(($pwds_n-1))"'})([^/])[^/]{1,}+/#\1%U\2%u/#g'
}
