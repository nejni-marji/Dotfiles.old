#!/bin/zsh

date="$1"
[[ -z $date ]] && return 1

secday=$((60*60*24))

day1=$(date +%s -d "00:00")
day2=$(date +%s -d "$date")

diff=$(( ($day2-$day1) / $secday ))
echo $diff
