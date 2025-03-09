delete_file () {
    local rip2b="${rip_bin}" ;
    local path="${1}" ;
    local item="${2}" ;
    [ -x "${rip2b}" ] && [ ! "${HOME}" = /root ] && {
            ${rip2b} --graveyard "${path}" "${item}" ;
    } || {
            mv "${item}" "${path}/${item##*/}$(date +%y-%b-%d-%H-%M-%S-%6N)" ||
            mv "${item}" "${path}/${item}$(date +%y-%b-%d-%H-%M-%S-%6N)" ;
    } ;
}
