#!/usr/bin/env dash
[ -z "${UPID_DIR}" ] && { [ -z "${XDG_RUNTIME_DIR}" ] && exit || UPID_DIR=${XDG_RUNTIME_DIR} ; }
printf '%s\n' "$$" > ${UPID_DIR}/rec_sc.pid
# -- record entire screen, with waybar widget
! kill -INT "$(cat ${UPID_DIR}/wf_recorder.pid)" 2>/dev/null 1>&2 && {
    [ ! -d ~/Videos/Recordings ] &&
        mkdir -p ~/Videos/Recordings 2>/dev/null 1>&2 ;
    {
        kill -USR1 "$(cat ${UPID_DIR}/rec_sc_d.pid)" ;
        wf-recorder \
            --audio=rec_monitor \
            -r 24 -f ~/Videos/Recordings/"screen-record-$(date +%Y-%m-%d-%H-%M-%S).mp4" \
            -F scale=w=1280:h=720:out_range=full \
            -g "0,0 1920x1080" &
                printf '%s' "$!" > ${UPID_DIR}/wf_recorder.pid ;
        kill -USR2 "$(cat ${UPID_DIR}/rec_sc_d.pid)" ;
    };
}
exit
# --
