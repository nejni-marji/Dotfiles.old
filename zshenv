#!/bin/zsh
#
# ~/.zshenv
#

#TODO: is this required?
! [[ $PATH =~ ~/bin ]] && PATH=~/bin/:$PATH
! [[ $path =~ ~/bin ]] && path=~/bin/:$path

export EDITOR=vim
