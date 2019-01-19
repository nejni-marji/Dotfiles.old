#!/usr/bin/env python3
from i3ipc import Connection
from subprocess import call

# This shows i3 keybind actions with a notification.
# It can be useful as an alternative to showkey.

i3 = Connection()

def notify(i3, event):
	# print(event.binding.__dict__)
	bind = event.binding

	mods_dict = [
		['Mod4', 'Super'],
		['shift', 'Shift'],
		['ctrl', 'Control'],
		['Mod1', 'Alt'],
	]
	mods = '+'.join([
		mod[1]
		for mod in mods_dict
		if mod[0] in bind.mods
	])
	if mods: mods += '+'

	call('notify-send -t 1000 -a i3wm'.split(' ')
		+ [bind.command, '%s%s' % (mods, bind.symbol)]
	)

i3.on('binding', notify)

i3.main()
