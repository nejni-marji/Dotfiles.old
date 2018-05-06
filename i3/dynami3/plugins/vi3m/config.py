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

def L(var): return '$lock %s; ' % var + E(I('manager.sh restart'))
def LM(var_list, opt):
	return ''.join(
		['$lock %s %s; ' % (i, opt) for i in var_list]
	) + E(I('manager.sh restart'))

multi_fancy = 'gaps titlebars'
multi_fancy = multi_fancy.split()

binds = {
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
		'av': E('VirtualBox'),
		'aV': E('vlc'),
	# }}}
	# {{{ i3-wm
		'iec': E(I('manager.sh edit main')),
		'ieC': E(I('manager.sh edit true')),
		'iev': E(I('manager.sh edit vi3m')),
		'ieV': E(I('manager.sh edit vars')),
		'ii': E('i3-input'),
		'il': E(I('autolock_locker.sh')),
		'iL': E(S('sleep .5 && xset dpms force off')),
		'im': E('i3-input '
			+ '-P "mark " -F "mark %s"'),
		'iM': E('i3-input '
			+ '-P "unmark " -F "unmark %s"'),
		# locks
		'if': LM(multi_fancy, '1'),
		'iF': LM(multi_fancy, '0'),
		'id': L('debugging'),
		'ic': L('colorclock'),
		'ibm': L('bar_mode'),
		'ibh': L('bar_hide'),
		'ibk': L('bar_key'),
		'ig': L('gaps'),
		'it': L('titlebars'),
	# }}}
	# {{{ mpc
		'ms': E('mpc stop'),
		'mS': E('mpc stop && mpc -h odroid pause'),
		'mte': E(A('mpd toggle repeat')),
		'mtr': E(A('mpd toggle random')),
		'mts': E(A('mpd toggle single')),
		'mtc': E(A('mpd toggle consume')),
		'mv': E('urxvt -e vimpc -h odroid'),
	# }}}
	# {{{ remote
		'rm': E(B(R('mosh'))),
		'rs': E(B(R('ssh'))),
		'rt': E(B(R('tmux'))),
		'rd': E(B(R('tmuxd'))),
		'rr': E(B(R('ranger'))),
		'rv': E(B(R('vimpc'))),
		'rf': E(B(R('sshfs'))),
		'ru': E(B(R('unmount'))),
		'rp': E(B(R('ping'))),
		'rb': E(B(R('mosh bot -f -o cat -n 24'))),
	# }}}
	# {{{ toggles
		'tb': E(S('pkill blueman-applet || blueman-applet')),
		'tc': E(S('pkill -x compton || compton -b')),
		'tC': E(S('pkill -x compton && compton -b || compton -b')),
		'tr': E(S('pkill -x redshift-gtk && redshift -x || redshift-gtk')),
		'tR': E(S('pkill -x redshift-gtk && redshift -O 4500 || redshift -O 4500')),
	# }}}
	# {{{ workspaces
		'wm': E('i3-input '
			+ '-P "move to workspace " -F "move to workspace %s"'),
		'wo': E('i3-input '
			+ '-P "move workspace to output " -F "move workspace to output %s"'),
		'wr': E('i3-input '
			+ '-P "rename workspace to " -F "rename workspace to %s"'),
	# }}}
	# {{{ utilities
		'up': E(T('pulsemixer')),
		'uP': E('pavucontrol'),
		'us': E('sc-controller && ' + B('keyswitch')),
		'uS': E(S('pkill -x sc-controller && pkill -x scc-daemon')),
		'uf': E(B('feshot')),
		'uF': E(B('feshot all')),
	# }}}
	# {{{ misc
		'zd': E('firefox --new-window https://github.com/nejni-marji/Dotfiles'),
		'zs': E('virtualbox --startvm School'),
		'zw': E('firefox --new-window wolframalpha.com'),
		'zW': F('title', 'Wolfram\\|Alpha(: Computational Intelligence)? - Mozilla Firefox$')
			+ '; '
			+ E('firefox wolframalpha.com'),
	# }}}
}

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
