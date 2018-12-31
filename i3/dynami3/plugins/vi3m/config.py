#!/usr/bin/env python3
from sys import argv
import os

# vim:fdm=marker:

# i3 modes are case-insensitive. Please don't try to use cased characters
# anywhere but the final character of the string. If you do, just know that
# generate_modes.py is likely to break, possibly silently.

term = 'urxvt'
shell = 'zsh'
editor = 'vim'
f = os.path.dirname(os.path.realpath(__file__))

def E(cmd): return '$exec %s' % cmd

def B(cmd): return '~/bin/%s' % cmd
def I(cmd): return '~/.i3/bin/%s' % cmd

def T(cmd): return '%s -e %s' % (term, cmd)
def S(cmd): return '%s -c "%s"' % (shell, cmd)

def R(cmd): return 'remote %s' % cmd
def F(attribute, pattern): return '[%s="%s"] focus' % (attribute, pattern)
def FC(wm_class): return F('class', wm_class)

def A(cmd): return '~/bin/sound %s' % cmd

def L(var): return '$lock %s; ' % var + '$mgr_run restart'
def LM(var_list, opt):
	return ''.join(
		['$lock %s %s; ' % (i, opt) for i in var_list]
	) + E(I('manager.sh restart'))

multi_fancy = 'gaps titlebars'
multi_fancy = multi_fancy.split()

ws_goto = {
	'm%i' % i: 'workspace number $w%i' % i
	for i in list(range(1, 10)) + [0]
}
ws_move = {
	'mm%i' % i: 'move container to workspace number $w%i' % i
	for i in list(range(1, 10)) + [0]
}


binds = { # {{{
	**ws_goto,
	**ws_move,
	# {{{ applications
		'ad': E('discord'),
		'af': E('firefox'),
		'aF': E('firefox --private-window'),
		'ag': E('gimp'),
		'aG': E('gimp ~/Pictures/Screenshots/Latest.png'),
		'al': E('leafpad'),
		'aL': E('libreoffice'),
		'as': E('steam'),
		'at': E(B('telegram')),
		'av': E('vlc'),
#		'aV': E('VirtualBox'),
	# }}}
	# {{{ i3-wm
		'iec': '$mgr_run edit preconf',
		'ieC': '$mgr_run edit postconf',
		'iem': '$mgr_run edit manager',
		'iev': '$mgr_run edit vi3m',
		'ieV': '$mgr_run edit vars',
		'ii': E('i3-input'),
#		'il': E(I('autolock_locker.sh')),
#		'iL': E(I('autolock_locker.sh' + ' & ' + S('sleep 60 && xset dpms force off'))),
		'im': E('i3-input '
			+ '-P "mark " -F "mark %s"'),
		'iM': E('i3-input '
			+ '-P "unmark " -F "unmark %s"'),
		# locks
#		'if': LM(multi_fancy, '1'),
#		'iF': LM(multi_fancy, '0'),
		'id': L('debugging'),
		'ic': L('colorclock'),
		'ibm': L('bar_mode'),
		'ibh': L('bar_hide'),
		'ibk': L('bar_key'),
		'ig': L('gaps'),
		'it': L('titlebars'),
		'iw': E('i3-input '
			+ '-P "set_wallpaper.sh " -F "$exec $i3b/set_wallpaper.sh %s"'),
	# }}}
	# {{{ workspaces
		'wm': E('i3-input '
			+ '-P "move to workspace " -F "move to workspace %s"'),
		'wM': E('i3-input '
			+ '-P "move to workspace number " -F "move to workspace number %s"'),
		'wo': E('i3-input '
			+ '-P "move workspace to output " -F "move workspace to output %s"'),
		'wr': E('i3-input '
			+ '-P "rename workspace to " -F "rename workspace to %s"'),
	# }}}
	# {{{ utilities
		'up': E(T('pulsemixer')),
		'uP': E('pavucontrol'),
		'uf': E(B('feshot')),
		'uF': E(B('feshot all')),
	# }}}
	# {{{ misc
#		'zd': E('firefox --new-window https://github.com/nejni-marji/Dotfiles'),
#		'zir': E(I('misc/reset_iss.sh')),
#		'zif': E(I('misc/focus_iss.sh')),
#		'zw': E('firefox --new-window wolframalpha.com'),
#		'zW': F('title', 'Wolfram\\|Alpha(: Computational Intelligence)? - Mozilla Firefox$')
#			+ '; '
#			+ E('firefox wolframalpha.com'),
	# }}}
} # }}}

configs = [
	{
		'mod': 'Return',
		#'key': '$mod+Return',
		#'sym': 'R-',
		'binds': binds
	}
]

try:
	if argv[1] in ['d', 'debug']:
		for i in binds:
			print('\'%s\': \'%s\'' % (i, binds[i]))
except:
	pass
