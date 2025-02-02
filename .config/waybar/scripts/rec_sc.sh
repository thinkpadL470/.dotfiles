#!/usr/bin/env dash
# -- record entire screen, with waybar widget
! kill -15 "$(cat ${UPID_DIR}/rec_sc.pid ${UPID_DIR}/wf-recorder.pid)" 2>/dev/null && {
        kill -USR1 "$(cat ${UPID_DIR}/rec_sc_d.pid)" ;
        mkdir -p ~/Videos/Recordings ;
        wf-recorder \
            --audio=rec_monitor \
            -r 24 \
            -f ~/Videos/Recordings/"screen-record-$(date +%Y-%m-%d-%H-%M-%S).mp4" \
            -F scale=w=1280:h=720:out_range=full \
            -g "0,0 1920x1080" & printf '%s' "$!" > ${UPID_DIR}/wf-recorder.pid
        kill -USR2 "$(cat ${UPID_DIR}/rec_sc_d.pid)" ;
    }
# --
