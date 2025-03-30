#!/usr/bin/env dash
set -xu
# --
cleanup () {
    rm -rf ${tmp_d}
}
trap "exit" HUP QUIT TERM INT ABRT
trap "cleanup ; kill -- -$$" EXIT 

mkdir_folders_inseq () {
    local first_dir="${1}" ;
    local end_dir="${2}/" ;
    local dir_seqence=$({
        until [ "${first_dir}" = "${end_dir}" ]
        do
            end_dir="${end_dir%/*}"
            printf '%s\n' "${end_dir}"
        done | sort ;
    }) ;
    [ ! "${HOME}" = /root ] && {
        printf '%s\n' "${dir_seqence}" |
        while IFS= read item ; do mkdir -m 700 ${item} ; done ;
    } 2>/dev/null ;
    [ "${HOME}" = /root ] && {
        printf '%s\n' "${dir_seqence}" |
        while IFS= read item ; do mkdir -m 755 ${item} ; done ;
    } 2>/dev/null ;
    [ -d "${end_dir}" ] && return 0 || return 1 ;
}
mkdir_folders_inseq_ret () {
    local ret=${?} ;
    local dir=${1}
    [ "${ret}" = 1 ] && {
        printf '%s\n' "${sh_name}: mkdir_folders_inseq: faild to make ${dir}" ;
        exit 1 ;
    };
    return 0 ;
}

generate_random_string () {
    local min="6" ;
    local max="12" ;
    local char_count=$(($(od -An -N4 -tu /dev/urandom)${min+%(${max+$max- }$min+1)${max++$min}})) ;
    tr -cd "A-Za-z1-9" < /dev/urandom | head -c ${char_count} ;
    return 0 ;
}

get_fsrc_dir_realpath () {
    local pattern=${1} ;
    realpath $({
        { find ~/../../ -iname "${pattern}" ;
        } 2>/dev/null |
        sort |
        head -n1 ;
    });
    return 0 ;
}

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

restart_sshd () {
    [ -d /etc/systemd ] && {
        systemctl restart sshd && return 0 || return 1 ;
    };
    [ ! -d /etc/systemd ] && {
        [ -d /data/data/com.termux/files/home ] && {
            pkill sshd ; sshd ; return 0 || return 1 ;
        };
        kill -TERM $(cat /run/sshd.pid) &&
        rm -rf /run/sshd.pid &&
        sshd && return 0 || return 1 ;
    };
}
restart_sshd_ret () {
    local ret="${?}" ;
    [ "${ret}" = 1 ] && {
        printf '%s\n' "${sh_name}: restart_sshd: sshd faild to restart" ;
        exit 0 ;
    };
    return 0 ;
}
# --

# --
{ auth=$(check__auth) ; check__auth_ret ; }
sh_name=$(basename $0)
tmpdir=${HOME}/tmp
tmp_d="${tmpdir}/$(generate_random_string).tmp.d"
[ ! -d "${tmp_d}" ] && mkdir_folders_inseq "${tmpdir}" "${tmp_d}" ; mkdir_folders_inseq_ret "${tmp_d}"
tmp_f1="${tmp_d}/sshd_config.$(generate_random_string)"
mkfifo -m 600 ${tmp_f1} &
rel_etc_p=$(get_fsrc_dir_realpath "etc")
conf_f="${rel_etc_p}/ssh/sshd_config"
# --

# --
grep 'PasswordAuthentication no' "${conf_f}" >/dev/null 2>&1 && {
    {
        sed 's/PasswordAuthentication\ no/PasswordAuthentication\ yes/g
        s/PubkeyAuthentication\ yes/PubkeyAuthentication\ no/g' ${conf_f} > ${tmp_f1} &
    } || { printf '%s\n' "${sh_name}: sed: sed faild to substitute settings in ${conf_f}" ; exit 1 ; };
}
grep 'PasswordAuthentication yes' "${conf_f}" >/dev/null 2>&1 && {
    {
        sed 's/PasswordAuthentication\ yes/PasswordAuthentication\ no/g
        s/PubkeyAuthentication\ no/PubkeyAuthentication\ yes/g' ${conf_f} > ${tmp_f1} &
    } || { printf '%s\n' "${sh_name}: sed: sed faild to substitute settings in ${conf_f}" ; exit 1 ; };
}
[ -n "${auth}" ] && { cat < ${tmp_f1} | ${auth} tee ${conf_f} && {
        restart_sshd ; restart_sshd_ret ;
    } && exit 0 || exit 1 ;
} || { cat < ${tmp_f1} | tee ${conf_f} && {
        restart_sshd ; restart_sshd_ret ;
    } && exit 0 || exit 1 ;
}
# --
