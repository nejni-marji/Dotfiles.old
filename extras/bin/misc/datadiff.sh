#!/bin/bash
echo $((
	$(du -s $1 | awk '{print $1}')
	-
	$(du -s $2 | awk '{print $1}')
))
