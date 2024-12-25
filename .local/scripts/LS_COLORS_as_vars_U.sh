#!/bin/dash
. ${HOME}/.dotfiles/.local/func/define_script_directories_in_variables.sh
{ 
    printf '%s%s\n%s%s\n' \
    'esc=$(printf ' \
    "'\033[')" \
    'nocolor="${esc}"' \
    "'0m'" ;
} > ${dotfu_d}/source_ls_colors_as_vars.sh
{ 
    printf '%s\n' "${LS_COLORS}" |
    tr ':' '\n' |
    sed 's/\(\.\|\*\)//g ; /\(=0\|=1\)$/d ; /^\(1=\|~\)/d
        s/+/plus/g ; s/\(\\\|-\)/_/g ; s/=/,=,/g' |
    sort -u -t, -k3 |
    tr -d ',' |
    sed "s/=/_es=\'/g ; s/$/\'/g" ;
} >> ${dotfu_d}/source_ls_colors_as_vars.sh
{
    cat ${fu_d}/source_ls_colors_as_vars.sh |
    sed '1,2d ; s/_.*=/_col=/g
         s/'"'"'/"${esc}"'"'"'/ ; s/'"'"'$/m'"'"'/' 
} >> ${dotfu_d}/source_ls_colors_as_vars.sh
