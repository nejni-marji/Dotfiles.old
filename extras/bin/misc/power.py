#!/usr/bin/env python3
from sys import argv
try:
	num = int(argv[1])
except:
	#print('You failed to give an int.')
	#exit()
	num = 1234567890

num = float(num)
count = 0
def iter(num, count):
	if num > 1000:
		count += 1
		num = num/1000
		return iter(num, count)
	else:
		return (num, count)

new_num, new_count = iter(num, count)

#(round(new_num, 2), new_count)
print(iter(num, count))
