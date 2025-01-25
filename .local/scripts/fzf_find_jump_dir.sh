#!/usr/bin/dash
# -- set vars, basedir, autentication program, clip aliaas and program, and targets to prune
. ~/.local/func/check_base_dir.sh
. ~/.local/func/check_auth.sh
. ~/.local/func/check_clip_copy.sh
prunedtargets=$(cat ~/.config/find/pruned | tr '\n' ' ')
# --

# -- IN_SHELL
[ -z "$lf" ] && {
    [ "${basedir}" = "/home/${USER}" -o "${basedir}" = "/data/data/com.termux/files/home" ] && {
        cd "$(find -L ${basedir} -type d ! \( ${prunedtargets% *} \) 2>/dev/null |
        fzf --reverse --header='Change Dir')" ;
    } || {
        cd "$(${auth} find -L ${basedirroot} -type d ! \( ${prunedtargets% *} \) 2>/dev/null |
        fzf --reverse --header='Change Dir')" ;
    };
}
# --

# -- IN_LF
[ -n "$lf" ] && {
    [ "${basedir}" = "/home/${USER}" ] && {
        find -L ${basedir} -type d ! \( ${prunedtargets% *} \) 2>/dev/null |
        fzf --reverse --header='Change Dir' ; exit 0
    } || {
        ${auth} find -L ${basedirroot} -type d ! \( ${prunedtargets% *} \) 2>/dev/null |
        fzf --reverse --header='Change Dir' ; exit 0
    };
}
# --
