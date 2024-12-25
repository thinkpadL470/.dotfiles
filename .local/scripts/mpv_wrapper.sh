#!/bin/bash
case "$1" in
    -p) 
        shift 1 ;
        setsid -f mpv --terminal='no' --mute='yes' "${@}"
    ;;
    -pi)
        shift 1 ;
        setsid -f mpv --terminal='no' --loop-playlist='inf' --shuffle --mute='yes' "${@}"
    ;;
    -fd)
        shift 1 ;
        find ./ -type f -iname "*${1}*" 2>/dev/null |
            setsid -f mpv --terminal='no' --mute='yes' --playlist=- "${@}"
    ;;
    *)
        printf -- 'invalid argument\nvalid arguments are\n'
        printf -- '-p\tplay all files in playlist\n'
        printf -- '-pi\tplay all files in playlist infinetly\n'
    ;;
esac

