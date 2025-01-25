#!/bin/bash
# -- select a part of screen to record, with waybar widget
! pkill -INT -P "$(ps -a -o "pid comm" | grep rec_sc_gif.sh | tr -cd '0-9')" wf-recorder 2>/dev/null &&
    geometry="$(slurp -d)" ;
    [ -n "$geometry" ] && {
        pkill -USR1 -x rec_sc_d.sh ;
        mkdir -p ~/Videos/Recordings ;
        wf-recorder \
            --audio=rec_monitor \
            -r 24 \
            -f ~/Videos/Recordings/"gif-record-$(date +%Y-%m-%d-%H-%M-%S).mp4" \
            -g "$geometry" ;
        pkill -USR2 -x rec_sc_d.sh ;
    }
# --
