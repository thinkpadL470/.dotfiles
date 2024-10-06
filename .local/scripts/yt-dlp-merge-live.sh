#!/bin/bash
NAME=${1%%.*}
EXT=${1#*.*.}
VID_EXT=${EXT%%.*}
ffmpeg -y -hide_banner -loglevel "repeat+info" -i "$1" -i "$2" -c copy -map "0:v:0" -map "1:a:0" -movflags "+faststart" "${NAME}.${VID_EXT}"
