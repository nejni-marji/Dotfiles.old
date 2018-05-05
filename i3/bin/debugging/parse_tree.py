#!/usr/bin/env python3
from i3ipc import Connection
from sys import argv
from traceback import print_exc

i3 = Connection()

layouts = {
	'splith': 'H',
	'splitv': 'V',
	'stacked': 'S',
	'tabbed': 'T',
}

opts = {}
opts_list = [
	'oneshot',
	'no-pango',
	'show-class',
	'only-child',
]

for i in opts_list:
	try:
		opts[i] = i in argv[1:]
	except:
		opts[i] = False

def parse_tree(con):
	if len(con.nodes) == 0:
		data = str()
		if con.focused == True:
			if opts['no-pango']:
				data += '*'
			else:
				data += '<u>'
		if opts['show-class']:
			data += con.window_class
		else:
			data += con.window_instance
		if con.focused == True:
			if opts['no-pango']:
				data += '*'
			else:
				data += '</u>'
		return data
	if opts['only-child'] and len(con.nodes) == 1:
		return parse_tree(con.nodes[0])
	if len(con.nodes) >= 1:
		children = [parse_tree(i) for i in con.nodes]
		data = str()
		if con.focused == True:
			if opts['no-pango']:
				data += '*'
			else:
				data += '<u>'
		data += layouts[con.layout]
		if con.focused == True:
			if opts['no-pango']:
				data += '*'
			else:
				data += '</u>'
		data += '['
		data += ' '.join(children)
		data += ']'
		return data

def show_tree(i3, event):
	try:
		workspace = i3.get_tree().find_focused().workspace()
		data = parse_tree(workspace)
		print(data, flush = True)
	except:
		print_exc()
		print(layouts[workspace.layout], flush = True)

workspace = i3.get_tree().find_focused().workspace()
data = parse_tree(workspace)
print(data, flush = True)

if not opts['oneshot']:
	i3.on('window', show_tree)
	i3.on('workspace', show_tree)
	i3.main()
