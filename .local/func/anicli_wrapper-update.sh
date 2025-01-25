#!/usr/bin/dash
# -- Defin vars, mainfile if mainfile is a link get real file path, define tmp file
main_file=${HOME}/.local/bin/ani-cli
[ -L "${main_file}" ] && main_file=$(readlink -f ${main_file})
ani_cli_tmp=$(${HOME}/.local/func/mk_tmp_f_n.sh ani_cli)
# --

# -- substitute interpeter to bash
[ -x "${main_file}" ] && ani-cli -U && {
    [ -x "${main_file}" -a -e "${ani_cli_tmp}" ] && {
        cat ${main_file} |
        sed '1s/#!\/bin\/sh/#!\/usr\/bin\/bash/' > ${ani_cli_tmp} ;
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
# --
