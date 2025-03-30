#!/usr/bin/env dash
[ -z "${UPID_DIR}" ] && { [ -z "${XDG_RUNTIME_DIR}" ] && exit || UPID_DIR=${XDG_RUNTIME_DIR} ; }
printf '%s\n' "$$" > ${UPID_DIR}/${HYPR_BAR}_d.pid

# -- set pids file to use for cleanup
pids="\
    ${UPID_DIR}/rec_sc_d.pid"
# --

# -- define cleanup function
cleanup () {
    { cat ${pids} | xargs kill -TERM ; rm ${pids} ;
    } 2>/dev/null
}
# --

# -- define trap and run hyprbar
trap "exit" HUP INT TERM QUIT
trap "cleanup ; kill -- -$$" EXIT
[ -n "${HYPR_BAR}" ] && { ${HYPR_BAR} & hyprbar_PID=$! ; }
wait "${hyprbar_PID}"
exit
