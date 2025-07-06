#!/usr/bin/env dash

# --
shName="$(basename "${0}")"
hash -r
shDeps="$(printf '%s\n' fzf find)"
printf '%s\n' "${shDeps}" | while IFS= read -r dep ;
do
    type "${dep}" >/dev/null 2>&1 ||
        printf '%s\n' "${shName}: dep check: missing binary ${dep}" && exit 1 ;
done ;
# --

# --
check_auth () {
    [ -d /data/data/com.termux/files/home ] && {
        printf '%s' "" ; return 0 ;
    };
    _doasBin="$(realpath /usr/bin/doas)" || {
        _doasBin="$(type doas)" &&
        _doasBin="$(realpath "${_doasBin##* }")" ;
    } || {
        _doasBin="" ; true ;
    };
    _sudoBin="$(realpath /usr/bin/sudo)" || {
        _sudoBin="$(type sudo)" &&
        _sudoBin="$(realpath "${_sudoBin##* }")" ;
    } || {
        _sudoBin="" ; true ;
    };
    [ -x "${_sudoBin}" ] && [ ! -x "${_doasBin}" ] && _auth=${_sudoBin}
    [ ! -x "${_sudoBin}" ] && [ -x "${_doasBin}" ] && _auth=${_doasBin}
    [ ! -x "${_sudoBin}" ] && [ ! -x "${_doasBin}" ] && return 1 ;
    printf '%s' "${_auth}" ;
    unset _sudoBin _doasBin _auth ;
    return 0 ;
}
check_auth_ret () {
    _ret="${?}" ;
    [ "${_ret}" = 1 ] && {
        printf '%s%s\n' \
            "${shName}: check_auth: setup your authentication, " \
            "uninstall either doas or sudo" ;
        exit 1 ;
    } ;
    unset _ret
    return 0 ;
}
# --

# --
check_base_dir () {
    [ -d /home ] && {
        baseDir=$(printf '%s' "${PWD}" | cut -d '/' -f '1-3') ;
        baseDirRoot="/" ;
    };
    [ -d /data/data/com.termux/files/home ] && {
        baseDir=$(printf '%s' "${PWD}" | cut -d '/' -f '1-6') ;
        baseDirRoot=$(printf '%s' "${PWD}" | cut -d '/' -f '1-5') ;
    };
}
# --

# --
auth="$(check_auth)" ; check_auth_ret
alias auth='${auth}'
check_base_dir
# --

# --
fdBin="$(x="$(type fd)" x="${x##* }" ; printf '%s' "${x}")"
[ ! -x "${fdBin}" ] && {
    findPru="$(tr '\n' ' ' < ~/.config/find/pruned)" &&
    find_cmd_Wargs () {
        [ "${1}" = -r ] &&
            auth find -L "${baseDir}" -type d ! \( "${findPru% *}" \) ;
        [ -z "${1}" ] &&
            find -L "${baseDir}" -type d ! \( "${findPru% *}" \) ;
    } ;
}
[ -x "${fdBin}" ] && { 
    fdPru="$(realpath ~/.config/fd/ignore)" &&
    find_cmd_Wargs () {
        [ "${1}" = -r ] &&
            auth fd -L -H -c never -t d --ignore-file "${fdPru}" . "${baseDir}" ;
        [ -z "${1}" ] &&
            fd -L -H -c never -t d --ignore-file "${fdPru}" . "${baseDir}" ;
    } ;
}
fzf_Wargs () { fzf --reverse --header='Change_Dir' ; }
termuxDir="/data/data/com.termux/files/home"
deskDir="/home/${USER}"
# --

# -- IN_SHELL
[ -z "$lf" ] && {
    {
        {
            [ "${baseDir}" = "${deskDir}" ] ||
            [ "${baseDir}" = "${termuxDir}" ] ;
        } && {
            cd "$(find_cmd_Wargs 2>/dev/null | fzf_Wargs)" || exit ;
        } ;
    } || {
        baseDir="${baseDirRoot}" ;
        cd "$(find_cmd_Wargs -r 2>/dev/null | fzf_Wargs)" || exit ;
    } ;
}
# --

# -- IN_LF
[ -n "$lf" ] && {
    { [ "${baseDir}" = "/home/${USER}" ] &&
        find_cmd_Wargs 2>/dev/null | fzf_Wargs ; exit ;
    } || {
        find_cmd_Wargs -r 2>/dev/null | fzf_Wargs ; exit ;
    };
}
# --
