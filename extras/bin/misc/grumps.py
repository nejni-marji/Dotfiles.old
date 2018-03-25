#!/usr/bin/env python3
import sys

# This is a script to rename Game Grumps videos so they sort properly.

print('# TODO:\n# Make revert a command line option.')

def failure(vid):
	if not vid.endswith('grumps.py'):
		print('# FAILED: ' + vid)
	return False

def check_convert(vid):
	pieces = vid.split('_-_')
	if not len(pieces) == 4:
		#print('Error: pieces not 4')
		return False
	#if not pieces[2].startswith('PART_'):
		#print('Error: not PART_')
		#return False
	if not pieces[3].startswith('Game_Grumps'):
		#print('Error: not Game_Grumps')
		return False
	if not pieces[3].endswith('.mp4'):
		#print('Error: not .mp4')
		return False
	return True

def check_revert(vid):
	pieces = vid.split('_-_')
	if not len(pieces) == 4:
		#print('Error: pieces not 4')
		return False
	if not pieces[1].startswith('PART_'):
		#print('Error: not PART_')
		return False
	if not pieces[3].startswith('Game_Grumps'):
		#print('Error: not Game_Grumps')
		return False
	if not pieces[3].endswith('.mp4'):
		#print('Error: not .mp4')
		return False
	return True

def number_convert(pieces):
	new_pieces = []
	for piece in pieces:
		if piece.startswith('PART_'):
			num = piece.split('_')[1].zfill(3)
			new_pieces.append('PART_' + num)
		else:
			new_pieces.append(piece)
	return new_pieces

def number_revert(pieces):
	new_pieces = []
	for piece in pieces:
		if piece.startswith('PART_'):
			num = str(int(piece.split('_')[1]))
			new_pieces.append('PART_' + num)
		else:
			new_pieces.append(piece)
	return new_pieces

def convert(vid):
	if not check_convert(vid):
		return failure(vid)
	pieces = number_convert(vid.split('_-_'))
	new_vid = '_-_'.join(pieces[i] for i in [0,2,1,3])
	return new_vid

def revert(vid):
	if not check_revert(vid):
		return failure(vid)
	pieces = number_revert(vid.split('_-_'))
	new_vid = '_-_'.join(pieces[i] for i in [0,2,1,3])
	return new_vid

if not len(sys.argv) == 1:
	action = convert
	for arg in sys.argv:
		if action(arg):
			print('mv -v %s %s' % (arg, action(arg)))
			#print(action(arg))
