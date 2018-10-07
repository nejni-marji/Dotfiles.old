#!/bin/bash
tmux new-session -t red -s red -d
tmux send-keys -t red 'redshift -vo; redshift -v; redshift -vo' C-m
