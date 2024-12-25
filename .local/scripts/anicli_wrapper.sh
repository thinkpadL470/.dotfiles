#!/bin/dash
. ~/.local/func/define_script_directories_in_variables.sh
[ "${#}" -lt 1 ] && ani-cli -q 720p ${@}
[ "${#}" -gt 0 ] &&
    while getopts 'Udh' option
    do
        case "${option}" in
            U) ${fu_d}/anicli_wrapper-update.sh
                ;;
            d) dub_flag_opts='-q 720p --dub'
                ;;
            h|?)
                {
                    printf '%s\n%s\n%s\n%s\n' \
                        "Usage: $(basename $0) [-h] [-d] [-U]" \
                        "   -h      Display this help" \
                        "   -d      Watch dubbed anime" \
                        "   -U      Update script subtituting interpeter to dash" ;
                } ; exit 1
                ;;
        esac
    done && { shift ; ani-cli ${dub_flag_opts} ${@} ; }
