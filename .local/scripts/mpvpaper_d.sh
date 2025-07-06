#!/usr/bin/env dash
[ -z "${UPID_DIR}" ] && {
    { [ -z "${XDG_RUNTIME_DIR}" ] && exit ; } || UPID_DIR=${XDG_RUNTIME_DIR} ;
}

# --
shName='mpvpaper_d.sh' 
shFPath="${HOME}"/.local/scripts/"${shName}"
shPathError="script assumes ""${shFPath}"" is the path for itself, \
simpily edit the variable 'shFPath' in the script, the script requiers \
this to be able to restart itself incase of stale pidfile"
[ ! -f "${shFPath}" ] && { notify-send -w -u critical -a "${shName}" \
    "Editing Needed" \
    "${shPathError}" ; exit 1 ;
}
lockDir="${UPID_DIR}"/"${shName}"'.d' ; pidFile="${lockDir}"'/pid'
# --

{
    ! mkdir "${lockDir}" && {
        pid="$(cat "${pidFile}")" ;
        ! kill -0 "${pid}" && [ "${UPID_DIR}" = "${lockDir%/*}" ] && {
            rm -rf "${lockDir}" ;
            "${shFPath}" "${@}" ;
        } ;
        exit 1 ;
    } ;
} 2>/dev/null || {
    printf '%s\n' "$$" > "${pidFile}" ;
} 2>/dev/null

# -- define cleanup function
cleanup () {
    { [ "${UPID_DIR}" = "${lockDir%/*}" ] && rm -rf "${lockDir}" ; } 2>/dev/null
}
# --

# -- setup traps
trap "exit" INT TERM HUP QUIT
trap 'cleanup ; kill -- -$$' EXIT
# --

# -- run mpvpaper, record PID and wait for mpvpaper to end
liveWp="${1}"
{ mpvpaper -o \
    "no-config load-scripts=no aid=no loop-file=inf vo=libmpv panscan=1" \
    '*' \
    "${liveWp}" & mpvPPid="$!" ; } || exit 1 ;
wait "${mpvPPid}"
# --
