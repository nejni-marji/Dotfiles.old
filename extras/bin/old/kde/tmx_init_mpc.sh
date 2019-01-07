#!/bin/bash

# make the session
# note the -x -y flags
tmux new-session -t mpc -s mpc -d -x 136 -y 31

# split the window
tmux split-window -t mpc:0.0 -h
tmux split-window -t mpc:0.1 -v
# resize the one pane we care about
tmux resize-pane -t mpc:0.1 -x 68 -y 6

# set commands for each pane
tmux send-keys -t mpc:0.0 'mpc_plist -r all' C-m
tmux send-keys -t mpc:0.1 'mpc_watch 5'      C-m
tmux send-keys -t mpc:0.2 'msh mpc'          C-m C-l

# is this important?
# apparently it's not
#mpc sticker dummy.ogg set rating 0
