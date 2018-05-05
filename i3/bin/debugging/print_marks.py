#!/usr/bin/env python3
from i3ipc import Connection
from sys import argv

i3 = Connection()

opts = {}
opts_list = [
	'oneshot',
]

for i in opts_list:
	try:
		opts[i] = i in argv[1:]
	except:
		opts[i] = False

def show_marks(i3, event):
	marks = str(i3.get_tree().find_focused().marks)
	print(marks, flush = True)

marks = str(i3.get_tree().find_focused().marks)
print(marks, flush = True)

if not opts['oneshot']:
	i3.on('window', show_marks)
	i3.on('workspace', show_marks)
	i3.on('binding', show_marks)
	i3.main()
