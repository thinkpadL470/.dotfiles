check__auth () {
    local doas_bin=$(realpath /usr/bin/doas) || {
        local doas_bin=$(type doas) && local doas_bin=$(realpath ${doas_bin##* }) ;
    } || true ;
    local sudo_bin=$(realpath /usr/bin/sudo) || {
        local sudo_bin=$(type sudo) && local sudo_bin=$(realpath ${sudo_bin##* }) ;
    } || true ;
    [ -x "${sudo_bin}" ] && [ ! -x "${doas_bin}" ] && local auth=${sudo_bin} || true ;
    [ ! -x "${sudo_bin}" ] && [ -x "${doas_bin}" ] && local auth=${doas_bin} || true ;
    [ ! -x "${sudo_bin}" ] && [ ! -x "${doas_bin}" ] && local auth=sudo || true ;
    printf '%s' "${auth}" ;
    return 0 ;
}
