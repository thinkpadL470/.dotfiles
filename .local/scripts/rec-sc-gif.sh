#!/bin/bash
if ! pkill -INT -P "$(pgrep -xo rec-sc-gif.sh)" wf-recorder 2>/dev/null; then
    geometry="$(slurp -d)"
    if [ -n "$geometry" ]; then
        mkdir -p ~/Videos/Recordings
        wf-recorder --audio=speaker_mon-mic.monitor -r 24 -f ~/Videos/Recordings/"gif-record-$(date +%Y-%m-%d-%H-%M-%S).mp4" -g "$geometry"
    fi
fi
