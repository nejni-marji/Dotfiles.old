#!/usr/bin/env python3
from time import sleep
from hotswap import hotswap
import i3ipc

i3 = i3ipc.Connection()

def hotswap_focus(args):
	if not len(args) >= 6: return None
	mark, default_ws = args[4:6]

	target = i3.get_tree().find_marked('^_?hs_%s_0$' % mark)
	if not len(target) == 1: return None
	target = target[0]

	if target.workspace().name == i3.get_tree().find_focused().workspace().name:
	# if False: # debug
		target.command('focus')
	else:
		workspace = [i for i in i3.get_workspaces() if i.name == default_ws]
		if not len(workspace) == 1: return None
		workspace = workspace[0]

		i3.command('workspace --no-auto-back-and-forth %s' % default_ws)
		sleep(0.1)
		while not i3.get_tree().find_focused().workspace().name == default_ws:
			print('hotswap_focus.py: waiting to find workspace %s' % default_ws)
			sleep(0.1)
		i3.command('[con_mark="^_?hs_%s_0$"] focus' % mark)

def on_binding(self, event):
	command = event.binding.command
	if event.binding.command.startswith('nop ipc hotswap focus'):
		return hotswap_focus(event.binding.command.split())

if __name__ == '__main__':
	i3.on('binding', on_binding)

	i3.main()
