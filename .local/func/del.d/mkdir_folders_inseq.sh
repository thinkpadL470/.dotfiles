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
    } ;
    [ "${HOME}" = /root ] && {
        printf '%s\n' "${dir_seqence}" |
        while IFS= read item ; do mkdir -m 755 ${item} ; done ;
    } ;
}
