pseq () {
    local min_num=${1} ;
    local step_count=${2} ;
    local max_num=${3} ;
    while [ "${min_num}" -lt "$(( ${max_num} + 1 ))" ]
    do
        printf '%s\n' "${min_num}"
        local min_num=$(( ${min_num} + ${step_count} ))
    done ;
    return 0 ;
}
