#!/usr/bin/env python3
from i3ipc import Connection

i3 = Connection()

def resize(i3, event, args):
	parent = i3.get_tree().find_focused().parent

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

	direction = {
		'splith': 'width',
		'splitv': 'height',
	}[parent.layout]

	command = 'resize {} {} 10 px or 10 ppt'.format(mode, direction)
	i3.command(command)

def flatten(i3, event, args):
	target = i3.get_tree().find_focused()
	parent = target.parent

	if not parent.nodes == [target]:
		exit(1)

	if any([i for i in [target, parent, parent.parent] if i.type == 'workspace']):
		exit(2)

	i3.command('[con_id="%s"] mark --add _flat_target' % target.id)
	i3.command('[con_id="%s"] mark --add _flat_parent' % parent.id)

	i3.command('workspace tmp')
	i3.command('open')
	i3.command('mark --add _flat_tmpcon')

	i3.command('[con_mark="^_flat_parent$"] swap container with mark _flat_tmpcon')
	i3.command('[con_mark="^_flat_target$"] swap container with mark _flat_tmpcon')
	i3.command('[con_mark="^_flat_target$"] focus')
	i3.command('[con_mark="^_flat_tmpcon$"] kill')

	i3.command('unmark _flat_target')

def on_bind(i3, event):
	args = event.binding.command

	if not args.startswith('nop ipc'):
		return None
	args = args.split()

	commands = {
		'resize': resize,
		'flatten': flatten,
	}
	try:
		commands[args[2]](i3, event, args[3:])
	except:
		pass

i3.on('binding', on_bind)

i3.main()
