#!/usr/bin/env python3
from i3ipc import Connection

i3 = Connection()

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
