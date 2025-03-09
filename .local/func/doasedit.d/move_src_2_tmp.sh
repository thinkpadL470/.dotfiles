move_src_2_tmp () {
    local tmp_f="${1}" ;
    { [ ! -r "${src_file}" ] && ${auth} [ -f "${src_file}" ] && ${auth} cat "${src_file}" > "${tmp_f}" ;
    } 2>/dev/null || {
    [ -r "${src_file}" ] && cat "${src_file}" > "${tmp_f}" ;
    } 2>/dev/null || {
        return 1 ;
    } ;
    cat "${tmp_f}" > "${tmp_f}.copy" ;
}
