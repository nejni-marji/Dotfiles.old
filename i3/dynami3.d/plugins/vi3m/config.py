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

def WR(cmd): # While Read
	return E('"{}"'.format(
		T(S(
			'{0}; while read; do clear; {0}; done'.format(cmd)
		)).replace('"', r'\\"')
	))

goto_I = 'workspace number %i'
goto_W = 'workspace number $w%i'
goto_S = 'workspace number %s'
send_I = 'move container to workspace number %i'
send_W = 'move container to workspace number $w%i'
send_S = 'move container to workspace number %s'
take_I = 'move container to workspace number %i; workspace back_and_forth'
take_W = 'move container to workspace number $w%i; workspace back_and_forth'
take_S = 'move container to workspace number %s; workspace back_and_forth'

maps = {}

maps['wm'] = '$exec i3-input -P "goto " -F "workspace number %s"'
maps['wM'] = '$exec i3-input -P "send " -F "move container to workspace number %s"'
maps['wz'] = '$exec "i3-input -P \'take \' -F \'move container to workspace number %s; workspace back_and_forth\'"'
maps['wr'] = '$exec i3-input -P "rename workspace to " -F "rename workspace to %s"'
maps['wo'] = '$exec i3-input -P "move workspace to output " -F "move workspace to output %s"'
maps['mZ'] = 'move container to workspace back_and_forth; workspace back_and_forth'

for i in range(0, 10):
	maps['m%i' % i] = goto_W % i
	maps['M%i' % i] = send_W % i
	maps['mz%i' % i] = take_W % i

workspace_maps = maps



binds = { # {{{
	**workspace_maps,
	# {{{ applications
		'ad': E('discord'),
		'aD': E('deluge-gtk'),
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
	# {{{ utilities
		'uc':  WR('cal -3'),
		'uC1': WR('cal -1'),
		'uCo': WR('cal -1'),
		'uCy': WR('cal -y'),
		'up': E(T('pulsemixer')),
		'uP': E('pavucontrol'),
		'uf': E(B('feshot')),
		'uF': E(B('feshot all')),
	# }}}
	# {{{ misc
		'zd': E(I('date_notify.sh fuzzy')),
		'zD': E(I('date_notify.sh')),
		'zpocr': E('echo -n "https://ocremix.org/remix/OCRxxxxx" | xsel -b -i'),
		# {{{ paste maps
			# display output
			'zpsl': WR(I('clipsync.sh')),
			'zpL': WR(I('clipsync.sh')),
			# run normally
			'zpsc': E(I('clipsync.sh c')),
			'zpsC': E(I('clipsync.sh c v')),
			'zpsp': E(I('clipsync.sh p')),
			'zpsP': E(I('clipsync.sh p v')),
			'zpsk': E(I('clipsync.sh k')),
			'zpsK': E(I('clipsync.sh k v')),
			'zpsx': E(I('clipsync.sh x')),
			'zpsX': E(I('clipsync.sh x v')),
		# }}}
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
