#!/bin/dash
# set -x
. ~/.local/func/check_auth_and_set_local_vars.sh
prunedtargets=$(cat ~/.config/find/pruned | tr '\n' ' ')
# [ IN_SHELL ]
[ -z "$lf" ] && {
    [ "${basedir}" = "/home/${USER}" -o "${basedir}" = "/data/data/com.termux/files/home" ] && {
        cd "$(find -L ${basedir} -type d ! \( ${prunedtargets% *} \) 2>/dev/null |
        fzf --reverse --header='Change Dir')" ;
    } || {
        cd "$(${auth} find -L ${basedirroot} -type d ! \( ${prunedtargets% *} \) 2>/dev/null |
        fzf --reverse --header='Change Dir')" ;
    };
}
# [ IN_LF ]
[ -n "$lf" ] && {
    [ "${basedir}" = "/home/${USER}" ] && {
        find -L ${basedir} -type d ! \( ${prunedtargets% *} \) 2>/dev/null |
        fzf --reverse --header='Change Dir' ;
    };
    [ ! "${basedir}" = "/home/${USER}" ] && basedir="/" && {
        ${auth} find -L ${basedir} -type d ! \( ${prunedtargets% *} \) 2>/dev/null |
        fzf --reverse --header='Change Dir' ;
    };
}