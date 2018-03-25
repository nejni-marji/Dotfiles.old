#!/bin/bash

EXT=pacstudy
a=all.$EXT
e=e.$EXT
d=D.$EXT
g=G.$EXT
i=i.$EXT
n=n.$EXT
f=F.$EXT

pacman -Qq  | sort -n > $a
pacman -Qqe | sort -n > $e
pacman -Qqg | awk '{print $2}' | sort -n | uniq > $g
pacman -Qqn | sort -n > $n
comm -3 $a $e > $d
comm -3 $a $g > $i
comm -3 $a $n > $f

for p in $(cat $a); do
	grep -r "^$p$" $e $d $g $i $n $f | grep -o '^.' | tr -d '\n'
	echo ": $p"
done | tee log.pacstudy
