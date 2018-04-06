#!/usr/bin/env python3
from i3ipc import Connection

i3 = Connection()

def auto_resize(i3, event, args):
	parent = i3.get_tree().find_focused().parent
	layout = parent.layout

	mode = args[0]
	if not mode in ['grow', 'shrink']:
		return None

	while not (
		parent.layout == 'output'
		or
		(
			not len(parent.nodes) == 1
			and
			parent.layout in ['splith', 'splitv']
		)
	):
		parent = parent.parent

	if parent.parent.layout == 'output':
		return None

	layout = {
		'splith': 'width',
		'splitv': 'height',
	}[parent.layout]

	command = 'resize {} {} 10 px or 10 ppt'.format(mode, layout)
	i3.command(command)

def on_bind(i3, event):
	args = event.binding.command

	if not args.startswith('nop ipc'):
		return None
	args = args.split()
	if not len(args) >= 4:
		return None

	commands = {
		'resize': auto_resize,
	}
	try:
		commands[args[2]](i3, event, args[3:])
	except:
		pass

i3.on('binding', on_bind)

i3.main()
