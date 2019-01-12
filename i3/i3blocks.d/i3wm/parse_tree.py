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
	'show-instance',
	'only-child',
	'shorten',
	'shorten-pure',
]

for i in opts_list:
	try:
		opts[i] = i in argv[1:]
	except:
		opts[i] = False

def parse_tree(con):

	if opts['no-pango']:
		foc_pre = '*'
		foc_pst = '*'
	else:
		foc_pre = '<u>'
		foc_pst = '</u>'

	# explicit container
	if len(con.nodes) == 0:

		data = str()

		if opts['show-instance']:
			con_name = con.window_instance
		else:
			con_name = con.window_class

		if opts['shorten']:
			if opts['shorten-pure']:
				con_disp = con_name[0]
			elif len(con_name) > 5:
				con_disp = con_name[:4] + '…'
		if 'con_disp' not in locals():
			con_disp = con_name

		if con.focused:
			data += foc_pre
		data += con_disp
		if con.focused:
			data += foc_pst

		return data



	if opts['only-child'] and len(con.nodes) == 1:
		return parse_tree(con.nodes[0])


	# implicit container
	if len(con.nodes) >= 1:

		children = [parse_tree(i) for i in con.nodes]
		data = str()

		if con.focused:
			data += foc_pre
		data += layouts[con.layout]
		if con.focused:
			data += foc_pst

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
	i3.on('binding', show_tree)
	i3.main()
