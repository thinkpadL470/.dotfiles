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
    local ret=${1} ;
    [ "${ret}" = 1 ] && {
        printf '%s\n' "${sh_name}: restart_sshd: sshd faild to restart" ;
        exit 0 ;
    };
    return 0 ;
}
