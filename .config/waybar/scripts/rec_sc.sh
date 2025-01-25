#!/bin/bash
# -- record entire screen, with waybar widget
! pkill -INT -P "$(ps -a -o "pid comm" | grep rec_sc.sh | tr -cd '0-9')" wf-recorder 2>/dev/null &&
    [ -n "geometry" ] && {
        pkill -USR1 -x rec_sc_d.sh ;
        mkdir -p ~/Videos/Recordings ;
        wf-recorder \
            --audio=rec_monitor \
            -r 24 \
            -f ~/Videos/Recordings/"screen-record-$(date +%Y-%m-%d-%H-%M-%S).mp4" \
            -F scale=w=1280:h=720:out_range=full \
            -g "0,0 1920x1080" ;
        pkill -USR2 -x rec_sc_d.sh ;
    }
# --
