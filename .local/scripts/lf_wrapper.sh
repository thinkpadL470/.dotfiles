#!/bin/bash
[ "${#}" -gt 1 ] && {
    printf '%s\n' \
        "only one option shall be used see $(basename ${0}) -h" ;
        exit 1 ;
}

[ "${1}" = "-h" ] && {
    printf '%s\n\t%s\n\t%s\n' \
        "Usage: $(basename $0) [-h] [-n] [-v]" \
        '-n    normal lf open' \
        '-v    open with one pane, no preview' ;
}
[ "${1}" = "-n" ] && { shift ; lf ${@} ; }
[ "${1}" = "-v" ] && { shift ; lf -config ~/.config/lf/lfrcvert ${@} ; }
