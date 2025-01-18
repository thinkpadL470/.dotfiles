#!/usr/bin/dash
. ~/.local/func/define_script_directories_in_variables.sh
hypr_conf="${HOME}/.config/hypr/hyprinput.conf"
main_mod=$(grep '$mainMod\( =\|=\)' "${hypr_conf}")
bind_field=$(
    grep 'bind' "${hypr_conf}" |
    sed -e 's/\(bind[d]\|bindd[em]\|\ =\ \)//g
        s/, /,/g ; s/ # /,/ ; s/\t/\ /g
        s/\$mainMod/'"${main_mod#*=}"'/g
        s/^\ *\s//g ; s/\ /_/g ; s/,/+/2' |
    cut -d ',' -f '1,2'
)
# printf '%s\n' "${bind_field}"
# { printf '%s' "${bind_field}" | pr -2 -t -a -w 100 ; }
${fu_d}/format_pad_column.sh "${bind_field}"
