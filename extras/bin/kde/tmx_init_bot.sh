#!/bin/bash

# make the session
tmux new-session -t bot -s bot -d

# set commands for each pane
tmux send-keys -t bot:0.0 'cd ~/Working/Nenmaj_Live' C-m
tmux send-keys -t bot:0.0 'reset' C-m
tmux send-keys -t bot:0.0 './main.py' C-m
