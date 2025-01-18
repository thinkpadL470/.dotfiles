main_file=${HOME}/.local/bin/ani-cli
[ -L "${main_file}" ] && main_file=$(readlink ${main_file})
ani_cli_tmp=$(${HOME}/.local/func/mk_tmp_f_n.sh ani_cli)
[ -x "${main_file}" ] && ani-cli -U && {
    [ -x "${main_file}" -a -e "${ani_cli_tmp}" ] && {
        cat ${main_file} |
        sed '1s/#!\/bin\/sh/#!\/bin\/bash/' > ${ani_cli_tmp} &&
    }; 
} && {
    chmod +x ${ani_cli_tmp} &&
    mv ${ani_cli_tmp} ${main_file} &&
    printf '%s\n' "subtituted interpeter from sh to bash" &&
    exit 0
} || {
    printf '%s\n' "subtituting interpeter from sh to bash faild" ;
    exit 1 ;
}
