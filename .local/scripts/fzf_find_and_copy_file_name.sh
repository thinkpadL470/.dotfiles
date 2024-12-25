#!/bin/dash
. ~/.local/func/check_auth_and_set_local_vars.sh
prunedtargets=$(cat ~/.config/find/pruned | tr '\n' ' ')
# [ IN_SHELL ]
[ -z "$lf" ] && {
    [ "${basedir}" = "/home/${USER}" ] && {
        ${cbc} "$(find -L ${basedir} -type f ! \( ${prunedtargets% *} \) 2>/dev/null |
        fzf --reverse --header='Copy File Path')" ; 
    };
    [ ! "${basedir}" = "/home/${USER}" ] && basedir="/" && {
        ${cbc} "$(${auth} find -L ${basedir} -type f ! \( ${prunedtargets% *} \) 2>/dev/null |
        fzf --reverse --header='Change Dir')" ;
    };
}
