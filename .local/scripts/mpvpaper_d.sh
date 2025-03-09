#!/bin/env dash
[ -z "${UPID_DIR}" ] && { [ -z "${XDG_RUNTIME_DIR}" ] && exit || UPID_DIR=${XDG_RUNTIME_DIR} ; }
printf '%s\n' "$$" > ${UPID_DIR}/mpvpaper_d.pid

# -- set pids file to use for cleanup
pids="\
${UPID_DIR}/mpvpaper.pid \
${UPID_DIR}/mpvpaper_d.pid"
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

# -- run mpvpaper, record PID and wait for mpvpaper to end
mpvpaper -o \
    "no-config load-scripts=no aid=no loop-file=inf vo=libmpv panscan=1" \
    '*' \
    "${1}" & mpvpaper_PID="$!"
printf '%s\n' "${mpvpaper_PID}" > ${UPID_DIR}/mpvpaper.pid
wait "${mpvpaper_PID}"
# --
