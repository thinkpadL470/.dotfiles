#!/usr/bin/env dash
[ -z "${UPID_DIR}" ] && { [ -z "${XDG_RUNTIME_DIR}" ] && exit || UPID_DIR=${XDG_RUNTIME_DIR} ; }
printf '%s\n' "$$" > ${UPID_DIR}/rec_sc_d.pid

# -- set pids file to use for cleanup, initlize the recordings variable
pids1="\
${UPID_DIR}/rec_sc.pid \
${UPID_DIR}/rec_sc_d_sleep.pid \
${UPID_DIR}/wf_recorder.pid"
recordings=0
# --

# -- define UpdateRec function for updating icon
UpdateRec () {
    [ "$recordings" -gt 0 ] && {
        { [ -f "${UPID_DIR}/rec_sc.pid" ] && printf '%s\n' "" ; } ||
        { [ -f "${UPID_DIR}/rec_sc_gif.pid" ] && printf '%s\n' "󰄄" ; } ;
    } || printf '%s\n' ""
}
# --

# -- define begin_record function for changeing status to recording
begin_record () {
    recordings=$(( ${recordings} + 1 ))
    UpdateRec
}
# --

# -- define end_record function for changeing status to recording
end_record () {
pids2="\
${UPID_DIR}/rec_sc.pid \
${UPID_DIR}/wf_recorder.pid"
{
    cat ${pids2} | xargs kill -TERM ;
    rm ${pids2} ;
} 2>/dev/null
    recordings=$(( ${recordings} - 1 ))
    UpdateRec
}
# --

# -- keep script open and alive
exec sleep 2147483647 & rec_sc_d_sleepPID=$!
printf '%s\n' "${rec_sc_d_sleepPID}" > ${UPID_DIR}/rec_sc_d_sleep.pid
# --

# -- define cleanup function for trap, define traps
cleanup () {
    {
        cat ${pids1} | xargs kill -TERM ;
        rm ${pids1} ;
    } 2>/dev/null
}
trap begin_record USR1
trap end_record USR2
trap "exit" INT TERM HUP QUIT
trap "cleanup ; kill -- -$$" EXIT
# --

# -- keep script open and alive
while :
do
    wait "${rec_sc_d_sleepPID}"
done
# --
