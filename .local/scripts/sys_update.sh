#!/usr/bin/env dash
set -u

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

update_pacman () {
    local pacman_c="${HOME}/.config/pacman/pacman.conf" ;
    [ -x /usr/bin/pacman ] && local pacman_b=/usr/bin/pacman || {
        local pacman_b=$(pacman_b=$(type pacman) ; printf '%s' "${pacman_b##* }") ;
    };
    [ -e "${pacman_c}" ] &&
        local cmd="${auth} ""${pacman_b} "'-Syyu --config '"${pacman_c}" ||
        local cmd="${auth} ""${pacman_b} "'-Syyu' ;
    [ -x "${pacman_b}" ] && ${cmd} ;
    [ ! -d "${pacman_c%/*}" ] && mkdir ${pacman_c%/*} ;
    [ -d "${pacman_c%/*}" ] && {
        pacman -Qqe > ${pacman_c%/*}/pac-PL-${system}.txt ;
        pacman -Qqm > ${pacman_c%/*}/pac_PL_m-${system}.txt ;
    };
    return 0 ;
}

update_pipx () {
    local pipx_c_d="${HOME}/.config/pipx"
    [ -x /usr/bin/pipx ] && local pipx_b=/usr/bin/pipx || {
        local pipx_b=$(pipx_b=$(type pacman) ; printf '%s' "${pipx_b##* }") ;
    };
    [ ! -d "${pipx_c_d}" ] && mkdir ${pipx_c_d} ;
    [ -d "${pipx_c_d}" ] && pipx upgrade-all && {
        pipx list |
        grep package |
        cut -d ' ' -f '5' > ~/.config/pipx/pip_PL-${system}.txt ;
    };
    return 0 ;
}

system=$(uname -n | tr '-' '_')
{ auth=$(check__auth) ; check__auth_ret ; }
update_pacman
update_pipx
