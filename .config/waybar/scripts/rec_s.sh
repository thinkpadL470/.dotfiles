#!/bin/bash
if ! pkill -INT -P "$(pgrep -xo recordscreen)" wf-recorder 2>/dev/null; then
  if [ -n "geometry" ]; then
    pkill -USR1 -x recordscreend
    mkdir -p ~/Videos/Recordings
    wf-recorder --audio=speaker_mon-mic.monitor -r 25 -f ~/Videos/Recordings/"screen-record-$(date +%Y-%m-%d-%H-%M-%S).mp4" -F scale=w=1280:h=720:out_range=full -g "0,0 1920x1080"
    pkill -USR2 -x recordscreend
  fi
fi