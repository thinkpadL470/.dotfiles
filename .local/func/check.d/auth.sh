check__auth () {
    [ -d /data/data/com.termux/files/home ] && { printf '%s' "" ; return 0 ; };
    local doas_bin=$(realpath /usr/bin/doas) || { # set doas bin, if not in default path try to find it with type
        local doas_bin=$(type doas) && local doas_bin=$(realpath ${doas_bin##* }) ;
    } || { doas_bin="" ; true ; };
    local sudo_bin=$(realpath /usr/bin/sudo) || { # like for doas, do the same for sudo
        local sudo_bin=$(type sudo) && local sudo_bin=$(realpath ${sudo_bin##* }) ;
    } || { sudo_bin="" ; true ; };
    [ -x "${sudo_bin}" ] && [ ! -x "${doas_bin}" ] && local auth=${sudo_bin} || true ;
    [ ! -x "${sudo_bin}" ] && [ -x "${doas_bin}" ] && local auth=${doas_bin} || true ;
    [ ! -x "${sudo_bin}" ] && [ ! -x "${doas_bin}" ] && return 1 ;
    printf '%s' "${auth}" ;
    return 0 ;
}
check__auth_ret () {
    local ret="${?}" ;
    [ "${ret}" = 1 ] && {
        printf '%s\n' "${sh_name}: check__auth: setup your authentication, uninstall either doas or sudo" ;
        exit 1 ;
    } ;
    return 0 ;
}
