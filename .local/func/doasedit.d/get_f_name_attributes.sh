get_f_name_attributes () {
    local file_name="${1##*/}" ;
    [ "${file_name}" = "${file_name##*.}" ] &&
        local file_extension="" || local file_extension="${file_name##*.}" ;
    printf '%s' "${file_name%.*}:${file_extension}" ;
    return 0 ;
}
