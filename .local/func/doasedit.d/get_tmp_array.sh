get_tmp_array () {
    [ -w "${src_file}" ] && {
        return 1 ;
    } ;
    local tmp_d="${tmpdir}/$(generate_random_string).tmp.d" ;
    [ ! -d "${tmp_d}" ] && {
        mkdir_folders_inseq "${tmpdir}" "${tmp_d}" || return 2 ;
    } ;
    local suffix=$(generate_random_string) ;
    local src_f_atributes=$(get_f_name_attributes "${src_file}") ;
    [ -z "${src_f_atributes##*.}" ] &&
        local tmp_f="${tmp_d}/${src_f_atributes%%.*}.${suffix}" ||
        local tmp_f="${tmp_d}/${src_f_atributes%%.*}.${suffix}.${src_f_atributes##*.}"
    printf '%s' "${tmp_d}:${tmp_f}" ;
    return 0 ;
}
