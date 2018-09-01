#!/bin/bash

[[ -z "$1" ]] && exit 142
group="$1"

list-live() {
	tmux ls | grep -P "^$group-\d{4}_\d{6}: .*\(group $group\)" | cut -d: -f1
}

for i in $(list-live); do
	tmux kill-session -C -t $i
done
