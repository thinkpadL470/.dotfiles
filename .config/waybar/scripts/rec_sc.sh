#!/usr/bin/env dash
[ -z "${UPID_DIR}" ] && { [ -z "${XDG_RUNTIME_DIR}" ] && exit || UPID_DIR=${XDG_RUNTIME_DIR} ; }

# -- set pids file to use for cleanup
pids="\
${UPID_DIR}/rec_sc.pid \
${UPID_DIR}/wf_recorder.pid"
# --

# -- define cleanup function
cleanup () {
    {
        cat ${pids##* } | xargs kill -TERM ;
        rm ${pids} ;
    } 2>/dev/null
}
# --

# -- record screen, with waybar widget, kill wf_rec if its running and exit
[ -f ${UPID_DIR}/wf_recorder.pid ] && wf_recPID=$(cat ${UPID_DIR}/wf_recorder.pid 2>/dev/null)
! kill -TERM "${wf_recPID}" 2>/dev/null && {
    # -- make recordings dir
    [ ! -d ~/Videos/Recordings ] && mkdir -p ~/Videos/Recordings ;
    # -- 
    # -- record PID of current script
    printf '%s\n' "$$" > ${UPID_DIR}/rec_sc.pid ;
    # --
    # -- setup trap for cleanup on exit
    trap "exit" TERM INT HUP QUIT ;
    trap "cleanup ; kill -- -$$" EXIT ;
    # --
    # -- set var for deamon pid to comunicate with to change waybar status icon
    rec_sc_dPID=$(cat ${UPID_DIR}/rec_sc_d.pid 2>/dev/null) ;
    # --
    # -- set the wf_rec format for screen mode
    wf_base_format='-F scale=w=1280:h=720:out_range=full' ;
    # --
    # -- if in gif mode change relevent vars, if in gif mode run slurp before running main code
    [ "${1}" = gif ] && { fnprefix=gif_record ; wf_base_format="" ; } ;
    [ ! "${1}" = gif ] || geometry="$(slurp -d)" && {
        # -- run wf_rec and wait for it to terminate, notify deamon when wf_rec starts and ends
        kill -USR1 "${rec_sc_dPID}" ; # change status to started recording
        wf-recorder \
            --audio=rec_monitor -r 24 \
            -f ~/Videos/Recordings/"${fnprefix:-screen-record}-$(date +%Y-%m-%d-%H-%M-%S).mp4" \
            ${wf_base_format} -g "${geometry:-0,0 1920x1080}" & wf_recPID=$! ;
            printf '%s\n' "${wf_recPID}" > ${UPID_DIR}/wf_recorder.pid ;
            wait "${wf_recPID}" ;
        kill -USR2 "${rec_sc_dPID}" ; # change status to stopped recording
        # --
    } ; exit
    # --
} || exit
# --
