#!/bin/dash
find ./ -type f -iname "*${1}*" 2>/dev/null | ~/.local/scripts/mpv_wrapper.sh -p --playlist=- &
