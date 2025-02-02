#!/usr/bin/env dash
# -- select a part of screen to record, with waybar widget
! kill -15 "$(cat ${UPID_DIR}/rec_sc_gif.pid ${UPID_DIR}/wf-recorder.pid)" 2>/dev/null &&
    geometry="$(slurp -d)" ;
    [ -n "$geometry" ] && {
        kill -USR1 "$(cat ${UPID_DIR}/rec_sc_d.pid)" ;
        mkdir -p ~/Videos/Recordings ;
        wf-recorder \
            --audio=rec_monitor \
            -r 24 \
            -f ~/Videos/Recordings/"gif-record-$(date +%Y-%m-%d-%H-%M-%S).mp4" \
            -g "$geometry" & printf '%s' "$!" > ${UPID_DIR}/wf-recorder.pid
        kill -USR2 "$(cat ${UPID_DIR}/rec_sc_d.pid)" ;
    }
# --
