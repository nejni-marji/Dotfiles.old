#!/bin/bash

cat << EOM
# This script **MUST** be run from your home directory.
# The Dotfiles folder **MUST** be in your home directory.

# This script should create symlinks from everything in Dotfiles except extras,
# and should also create a symlink for Dotfiles/extras/bin to ~/bin. It will
# also add symlinks for everything in Dotfiles/extras/config to the ~/.config
# directory. However, it will not do this automatically. You will have to pass
# it to eval or pipe it into a shell.

EOM

for i in $(ls Dotfiles); do
	echo ln -s Dotfiles/$i .$i
done
echo rm .extras
echo ln -s Dotfiles/extras/bin bin
for i in $(ls Dotfiles/extras/config); do
	echo ln -s ../Dotfiles/extras/config/$i .config/$i
done
