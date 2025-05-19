#!/usr/bin/env dash
[ -z "${UPID_DIR}" ] && { [ -z "${XDG_RUNTIME_DIR}" ] && exit || UPID_DIR=${XDG_RUNTIME_DIR} ; }
printf '%s\n' "$$" > ${UPID_DIR}/mpvpaper_d.pid


# app_name=mpvpaper
# script_name=$(basename $0)
# lockdir="${UPID_DIR}/${script_name}"
# pidfile="${lockdir}/pid"
# ! mkdir $lockdir 2>/dev/null && {
#     pid=$(cat $pidfile) ;
#     ! kill -0 ${pid} 2>/dev/null && {
#         rm -rf ${lockdir} ;
#         exec "$0" "$@" ;
#     } ;
#     exit 1 ;
# } || {
#     printf '%s\n' "$$" > ${pidfile} ;
# }

# -- set pids file to use for cleanup
pids="\
${UPID_DIR}/mpvpaper.pid \
${UPID_DIR}/mpvpaper_d.pid"
# --

# -- define cleanup function
cleanup () {
    { rm ${pids} ; } 2>/dev/null
}
# --

# -- setup traps
trap "exit" INT TERM HUP QUIT
trap "cleanup ; kill -- -$$" EXIT
# --

# -- run mpvpaper, record PID and wait for mpvpaper to end
live_wp="${1}"
while true
do
    { mpvpaper -o \
        "no-config load-scripts=no aid=no loop-file=inf vo=libmpv panscan=1" \
        '*' \
        "${live_wp}" & mpvpaper_PID="$!" ; } || exit 1
    printf '%s\n' "${mpvpaper_PID}" > ${UPID_DIR}/mpvpaper.pid
    wait "${mpvpaper_PID}"
done
# --
