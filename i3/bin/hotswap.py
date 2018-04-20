#!/usr/bin/env python3
import i3ipc
from re import compile as re_compile

i3 = i3ipc.Connection()

uuid = '([a-f\d]{8}(-[a-f\d]{4}){3}-[a-f\d]{12}?)'
regex = re_compile('^_?hs_[A-Za-z0-9]+_(?!0$)(\d+|%s)+$' % uuid).match

def hotswap(workspace):
	data = []
	for con in workspace.descendents():
		if not con.workspace().name == workspace.name: continue
		if con.marks == []: continue
		marks = [i for i in con.marks if regex(i)]
		if not len(marks) == 1: continue
		mark = marks[0]
		data.append(mark)

	for mark in data:
		source = 'hs_%s_0' % [i for i in mark.split('_') if i][1]
		target = mark
		command = '[con_mark="^_?%s$"] swap container with mark %s' % (source, target)
		i3.command(command)

def on_workspace_focus(self, event):
	workspace = event.current
	hotswap(workspace)

def on_window(self, event):
	workspace = i3.get_tree().find_focused().workspace()
	hotswap(workspace)

def on_binding(self, event):
	command = event.binding.command
	if command == 'nop ipc hotswap swapthis':
		command  = 'exec i3-input '
		command += '-P "hotswap swapthis " '
		command += '-F "mark hs_%s_0"'
		i3.command(command)
		return None
	if command == 'nop ipc hotswap swapthis hide':
		command  = 'exec i3-input '
		command += '-P "hotswap swapthis " '
		command += '-F "mark _hs_%s_0"'
		i3.command(command)
		return None
	if command == 'nop ipc hotswap swaphere':
		command  = 'exec i3-input '
		command += '-P "hotswap swaphere " '
		command += '-F "mark hs_%s_$(uuidgen)"'
		i3.command(command)
		return None

i3.on('workspace::focus', on_workspace_focus)
i3.on('window', on_window)
i3.on('binding', on_binding)

i3.main()
