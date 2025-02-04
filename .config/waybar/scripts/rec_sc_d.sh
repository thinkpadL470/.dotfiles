#!/usr/bin/env dash
[ -z "${UPID_DIR}" ] && { [ -z "${XDG_RUNTIME_DIR}" ] && exit || UPID_DIR=${XDG_RUNTIME_DIR} ; }
# -- deamon for recording scripts
printf '%s\n' "$$" > ${UPID_DIR}/rec_sc_d.pid
pids1="\
    ${UPID_DIR}/rec_sc.pid \
    ${UPID_DIR}/rec_sc_gif.pid \
    ${UPID_DIR}/rec_sc_d.pid \
    ${UPID_DIR}/rec_sc_d_sleep.pid"
recordings=0
UpdateRec () {
    [ "$recordings" -gt 0 ] &&
        [ -f "$(cat ${UPID_DIR}/rec_sc.pid)" ] && echo ""
        [ -f "$(cat ${UPID_DIR}/rec_sc_gif.pid)" ] && echo "󰄄"
    [ "$recordings" -lt 1 ] && echo
};

begin_record () {
    recordings=$((recordings + 1))
    UpdateRec
};

end_record () {
    pids2="\
    ${UPID_DIR}/rec_sc.pid \
    ${UPID_DIR}/rec_sc_gif.pid"
    rm ${pids2} 2>/dev/null 1>&2 || true
    recordings=$((recordings - 1))
    UpdateRec
};

exec sleep 2147483647 & printf '%s\n' "${!}" > ${UPID_DIR}/rec_sc_d_sleep.pid
trap begin_record SIGUSR1
trap end_record SIGUSR2
trap "{ kill -TERM $(cat ${pids1##* }) ; rm ${pids1} ; } 2>/dev/null 1>&2 ; exit" INT TERM QUIT
trap "kill 0" EXIT
while true
do
    wait "$(cat ${pids1##* })"
done
kill -TERM -$$
# --
