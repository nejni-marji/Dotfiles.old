#!/usr/bin/env python3
import argparse
from sys import argv
from traceback import print_exc

from i3ipc import Connection

parser = argparse.ArgumentParser()
parser.add_argument(
	'-p', '--pango',
	action='store_true',
	dest='pango',
)
parser.add_argument(
	'-I', '--show-instance',
	action='store_false',
	dest='use_class',
	help='show window_instance instead of window_class',
)
parser.add_argument(
	'-C', '--only-child',
	action='store_true',
	dest='only_child',
	help='if the root container has one node, show that as the root',
)
parser.add_argument(
	'-s', '--shorten',
	action='store',
	type=int,
	default=-1,
	dest='shorten',
	help='shorten names to this length, 0 for no limit',
)

args = parser.parse_args()
opts = args.__dict__



i3 = Connection()

layouts = {
	'splith': 'H',
	'splitv': 'V',
	'stacked': 'S',
	'tabbed': 'T',
}

def parse_tree(con):
	if opts['pango']:
		foc_pre = '<u>'
		foc_pst = '</u>'
	else:
		foc_pre = '*'
		foc_pst = '*'

	# explicit container
	if len(con.nodes) == 0:

		if con.type == 'workspace':
			return 'E[{}]'.format(con.name)

		data = str()

		if opts['use_class']:
			con_name = con.window_class
		else:
			con_name = con.window_instance

		if opts['shorten'] > 0:
			if opts['shorten'] == 1:
				con_disp = con_name[0]
			elif len(con_name) > opts['shorten']:
				con_disp = con_name[:opts['shorten']-1] + '…'
		if 'con_disp' not in locals():
			con_disp = con_name

		if con.focused:
			data += foc_pre
		data += con_disp
		if con.focused:
			data += foc_pst

		return data



	if opts['only_child'] and len(con.nodes) == 1:
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



workspace = i3.get_tree().find_focused().workspace()
data = parse_tree(workspace)
print(data, flush = True)
