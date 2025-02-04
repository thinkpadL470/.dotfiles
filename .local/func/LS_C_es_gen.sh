#!/usr/bin/env dash
. ${HOME}/.dotfiles/.local/func/define_script_directories_in_variables.sh
# -- add text to so sorceing of script puts escape charecter in a var append to script
{
    printf '%s%s\n%s%s\n' \
    'esc=$(printf ' \
    "'\033[')" \
    'nocolor="${esc}"' \
    "'0m'" ;
} > ${dotsh_d}/LS_C_es_vars.sh
# --

# -- generate escape sequences set in vars from LS…COLORS var append to script
{ 
    printf '%s\n' "${LS_COLORS}" |
    tr ':' '\n' |
    sed 's/\(\.\|\*\)//g ; /\(=0\|=1\)$/d ; /^\(1=\|~\)/d
        s/+/plus/g ; s/\(\\\|-\)/_/g ; s/=/,=,/g' |
    sort -u -t, -k3 |
    tr -d ',' |
    sed "s/=/_es=\'/g ; s/$/\'/g" ;
} >> ${dotsh_d}/LS_C_es_vars.sh
# --

# -- extract es vars and make colorvars out of them and append to script
{
    cat ${sh_d}/LS_C_es_vars.sh |
    sed '1,2d ; s/_.*=/_col=/g
         s/'"'"'/"${esc}"'"'"'/ ; s/'"'"'$/m'"'"'/' 
} >> ${dotsh_d}/LS_C_es_vars.sh
# --
