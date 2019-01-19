#!/usr/bin/env python3
from sys import argv
import os

# vim:fdm=marker:

# Helper variables
term = 'urxvt'
shell = 'zsh'
editor = 'vim'

# Helper functions
def E(cmd): return '$exec %s' % cmd

def B(cmd): return '~/bin/%s' % cmd
def I(cmd): return '~/.i3/bin/%s' % cmd

def T(cmd): return '%s -e %s' % (term, cmd)
def S(cmd): return '%s -c "%s"' % (shell, cmd)

def F(attribute, pattern): return '[%s="%s"] focus' % (attribute, pattern)
def FC(wm_class): return F('class', wm_class)

def L(var): return '$lock %s; ' % var + '$mgr_run restart'

# Comprehensions to generate enumerated values
move_focus = {
	'm%i' % i: 'workspace number $w%i' % i
	for i in list(range(1, 10)) + [0]
}

move_send = {
	'mm%i' % i: 'move container to workspace number $w%i' % i
	for i in list(range(1, 10)) + [0]
}

move_send_focus = {
	'mz%i' % i: 'move container to workspace number $w%i; workspace back_and_forth' % i
	for i in list(range(1, 10)) + [0]
}

binds = { # {{{

	'gf': F('con_mark', '^_hs_tg_0'),

	**move_focus,
	**move_send,
	**move_send_focus,
	'mZ': 'move container to workspace back_and_forth; workspace back_and_forth',
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
		'aV': E('VirtualBox'),
	# }}}
	# {{{ i3-wm
		'iec': '$mgr_run edit preconf',
		'ieC': '$mgr_run edit postconf',
		'iem': '$mgr_run edit manager',
		'iev': '$mgr_run edit vi3m',
		'ieV': '$mgr_run edit vars',
		'ii': E('i3-input'),
		'il': E(I('autolock_locker.sh')),
		'iL': E(I('autolock_locker.sh' + ' & ' + S('sleep 60 && xset dpms force off'))),
		'im': E('i3-input '
			+ '-P "mark " -F "mark %s"'),
		'ium': E('i3-input '
			+ '-P "[con_id=__focused__] unmark " -F "[con_id=__focused__] unmark %s"'),
		'iuM': E('i3-input '
			+ '-P "unmark " -F "unmark %s"'),
		# locks
		'id': L('debugging'),
#		'ic': L('colorclock'),
		'ibm': L('bar_mode'),
		'ibh': L('bar_hide'),
		'ibk': L('bar_key'),
		'ibt': L('tray'),
#		'ig': L('gaps'),
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
		'zpocr': E('echo -n "https://ocremix.org/remix/OCRxxxxx" | xsel -b -i'),
		'zfs': E(I('web_search.sh')),
		'zfSi': E(I('web_search.sh \'!ddgi\'')),
		'zfd': E('firefox --new-window https://github.com/nejni-marji/Dotfiles'),
		'zfw': E('firefox --new-window wolframalpha.com'),
		'zfW': F('title', 'Wolfram\\|Alpha(: Computational Intelligence)? - Mozilla Firefox$')
			+ '; '
			+ E('firefox wolframalpha.com'),
	# }}}
} # }}}

configs = [
	{
		'mod': 'Return',
		# The presence of 'mod' overrides 'key' and 'sym'
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
