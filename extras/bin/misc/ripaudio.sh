#!/bin/bash

echo ffmpeg -i "$1" -vn -ac 2 -ar 44100 -ab 320k -f mp3 $2
