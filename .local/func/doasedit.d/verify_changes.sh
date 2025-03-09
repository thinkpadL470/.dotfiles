verify_changes () {
    local tmp_f=${1}
    cmp -s "${tmp_f}" "${tmp_f}.copy" && return 1 || {
        local attempt=0 ;
        until doas cp -f "${tmp_f}" "${src_file}"
        do
            local attempt=$((attempt + 1))
            [ "${attempt}" -ge 3 ] && {
                return 2
            }
        done ;
        return 0 ;
    } ;
}
