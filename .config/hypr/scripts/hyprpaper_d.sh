#!/usr/bin/env dash
[ -z "${UPID_DIR}" ] && { [ -z "${XDG_RUNTIME_DIR}" ] && exit || UPID_DIR=${XDG_RUNTIME_DIR} ; }
printf '%s\n' "$$" > ${UPID_DIR}/hyprpaper_d.pid

# -- set pids file to use for cleanup
pids="\
${UPID_DIR}/hyprpaper.pid \
${UPID_DIR}/hyprpaper_d.pid"
# --

# -- define cleanup function
cleanup () {
    { 
        rm ${pids} ;
    } 2>/dev/null
}
# --

# -- setup traps
trap "exit" INT TERM HUP QUIT
trap "cleanup ; kill -- -$$" EXIT
# --

# -- run hyprpaper, record PID and wait for hyprpaper to exit
hyprpaper & hyprpPID=$!
printf '%s\n' "${hyprpPID}" > ${UPID_DIR}/hyprpaper.pid
wait "${hyprpPID}"
exit
