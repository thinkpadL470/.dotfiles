#!/usr/bin/dash
. ~/.local/func/check_auth_and_set_local_vars.sh
prunedtargets=$(cat ~/.config/find/pruned | tr '\n' ' ')
# [ IN_SHELL ]
[ -z "$lf" ] && {
    [ "${basedir}" = "/home/${USER}" -o "${basedir}" = "/data/data/com.termux/files/home" ] && {
        ${cbc} "$(find -L ${basedir} -type f ! \( ${prunedtargets% *} \) 2>/dev/null |
        fzf --reverse --header='Copy File Path')" ; 
    } || {
        ${cbc} "$(${auth} find -L ${basedir} -type f ! \( ${prunedtargets% *} \) 2>/dev/null |
        fzf --reverse --header='Change Dir')" ;
    };
}
