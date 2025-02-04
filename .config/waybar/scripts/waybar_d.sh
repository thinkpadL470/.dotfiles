#!/usr/bin/env dash
[ -z "${UPID_DIR}" ] && { [ -z "${XDG_RUNTIME_DIR}" ] && exit || UPID_DIR=${XDG_RUNTIME_DIR} ; }
pids="\
    ${UPID_DIR}/wf_recorder.pid \
    ${UPID_DIR}/rec_sc_d.pid \
    k  \
    ${UPID_DIR}/hyprbar_d.pid"
printf '%s' "$$" > ${UPID_DIR}/hyprbar_d.pid
trap "{ { cat ${pids% k *} | xargs kill -TERM ; } ; rm ${pids% k *} ${pids#* k } ; } 2>/dev/null 1>&2 ; exit" INT TERM QUIT
trap "kill 0" EXIT
[ -n "${HYPR_BAR}" ] && { ${HYPR_BAR} & hyprbar_PID=$! ; }
[ -z "${HYPR_BAR}" ] && { waybar & hyprbar_PID=$! ; }
wait "${hyprbar_PID}"
kill -TERM -$$
