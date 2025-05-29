#!/usr/bin/env dash
answer="$(printf '%s\n' "${1}" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')"
dmenuCmd () { _answer="${answer} = " ; tofi --require-match=false --prompt-text="${_answer}" ; unset _answer ; }
action="$(printf '%s\n' Cbc Close | dmenuCmd)"
case "${action}" in
    "Cbc") wl-copy "${answer}" ;;
    "Close") ;;
    *) ${0} "${answer} ${action}" ;;
esac
