#!/bin/bash
if ! pkill -INT -P "$(pgrep -xo rec_sc_gif.sh)" wf-recorder 2>/dev/null; then
  geometry="$(slurp -d)"
  if test -n "$geometry" ; then
    pkill -USR1 -x rec_sc_d.sh
    mkdir -p ~/Videos/Recordings
    wf-recorder --audio=speaker_mon-mic.monitor -d /dev/dri/renderD128 -r 24 -f ~/Videos/Recordings/"gif-record-$(date +%Y-%m-%d-%H-%M-%S).mp4" -g "$geometry"
    pkill -USR2 -x rec_sc_d.sh
  fi
fi
