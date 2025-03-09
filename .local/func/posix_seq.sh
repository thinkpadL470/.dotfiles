posix_seq () {
    local args="${@}"
    printf '%d\n' "${args}" 2>/dev/null 1>/dev/null && {
        [ "${#}" -lt 1 ] && { exit 1 ;};
        [ "${#}" -eq 1 ] && { exit 1 ;};
        [ "${#}" -gt 3 ] && { exit 1 ;};
        [ "${#}" -eq 2 ] && {
            min_num=${1}
            step_count=1
            max_num=${2}
        };
        [ "${#}" -eq 3 ] && {
            min_num=${1}
            step_count=${2}
            max_num=${3}
        };
        while [ "${min_num}" -lt "$(( ${max_num} + 1 ))" ]
        do
            printf '%s\n' "${min_num}"
            min_num=$(( ${min_num} + ${step_count} ))
        done ;
        
    } && return 0 || return 1 ;
}
posix_seq_ret () {
    ret="${?}" ;
    [ "${ret}" = 1 ] && {
        echo "${sh_name}: posix_seq: argument contains other charecters than digets" ;
        exit 1 ;
    }
    return 0 ;
}
