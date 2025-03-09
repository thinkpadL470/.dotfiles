#!/usr/bin/env dash
check__auth () {
    local doas_bin=$(realpath /usr/bin/doas) || { # set doas bin, if not in default path try to find it with type
        local doas_bin=$(type doas) && local doas_bin=$(realpath ${doas_bin##* }) ;
    } || { doas_bin="" ; true ; } ;
    local sudo_bin=$(realpath /usr/bin/sudo) || { # like for doas, do the same for sudo
        local sudo_bin=$(type sudo) && local sudo_bin=$(realpath ${sudo_bin##* }) ;
    } || { sudo_bin="" ; true ; } ;
    [ -x "${sudo_bin}" ] && [ ! -x "${doas_bin}" ] && local auth=${sudo_bin} || true ;
    [ ! -x "${sudo_bin}" ] && [ -x "${doas_bin}" ] && local auth=${doas_bin} || true ;
    [ ! -x "${sudo_bin}" ] && [ ! -x "${doas_bin}" ] && return 1 ;
    printf '%s' "${auth}" ;
    return 0 ;
}
check__auth_ret () {
    ret="${?}" ;
    [ "${ret}" = 1 ] && {
        printf '%s\n' "${sh_name}: check__auth: setup your authentication, uninstall either doas or sudo" ;
        exit 1 ;
    } ;
    return 0 ;
}

update_pacman () {
    local pacman_c="${HOME}/.config/pacman/pacman.conf" ;
    local cmd=$(realpath /usr/bin/pacman) ;
    [ -e "${pacman_c}" ] &&
        local cmd="${auth}"' pacman -Syyu --config '"${pacman_c}" ||
        local cmd="${auth}"' pacman -Syyu' ;
    [ ! -d "${pacman_c%/*}" ] && mkdir ${pacman_c%/*} ;
    [ -d "${pacman_c%/*}" ] && {
        pacman -Qqe > ${pacman_c%/*}/pac-PL-${system}.txt ;
        pacman -Qqm > ${pacman_c%/*}/pac_PL_m-${system}.txt ;
    };
}

update_pipx () {
    local pipx_c_d="${HOME}/.config/pipx"
    [ ! -d "${pipx_c_d}" ] && mkdir ${pipx_c_d} ;
    [ -d "${pipx_c_d}" ] && pipx upgrade-all && {
        pipx list |
        grep package |
        cut -d ' ' -f '5' > ~/.config/pipx/pipPL-${system}.txt ;
    }
}

system=$(uname -r | tr '-' '_' | tr '.' '_')
{ auth=$(check__auth) ; check__auth_ret ; }
[ -x /usr/bin/pacman ] && update_pacman
