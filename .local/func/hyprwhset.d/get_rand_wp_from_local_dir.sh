get_rand_wp_from_local_dir () {
    local min="1" ;
    local nl_f_list=$(find ~/Pictures/wallpapers/ -type f -print0 | tr '\0\n' '\n\0') ;
    local tot_files=$(printf '%s' "${nl_f_list}" | wc -l) ;
    local max="${tot_files}" ;
    local number=$(($(od -An -N4 -tu /dev/urandom)${min+%(${max+$max- }$min+1)${max++$min}})) ;
    { printf '%s' "${nl_f_list}" | tr '\0\n' '\n\0' | cut -d "$(printf '\0')" -f "${number}" ; } 2>/dev/null ;
    return 0 ;
}
