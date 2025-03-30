#!/usr/bin/env dash
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
printf '%s\n' "${bind_field}" | awk -F'+' '{ printf "%-16s\t%s\n", $1, $2}' | sort -u | fzf
