#!/usr/bin/env dash
# --
{
    printf '%s\n%s%s\n%s%s\n' \
    'get_ls_col_es () {' \
    'esc=$(printf ' \
    "'\033[')" \
    'nocolor="${esc}"' \
    "'0m'" ;
} > ~/.dotfiles/.local/func/ll.d/get_ls_col_es.sh
# --

# --
{ 
    printf '%s\n' "${LS_COLORS}" |
    tr ':' '\n' |
    sed 's/\(\.\|\*\)//g ; /\(=0\|=1\)$/d ; /^\(1=\|~\)/d
        s/+/plus/g ; s/\(\\\|-\)/_/g ; s/=/,=,/g' |
    sort -u -t, -k3 |
    tr -d ',' |
    sed "s/=/_es=\'/g ; s/$/\'/g" ;
} >> ~/.dotfiles/.local/func/ll.d/get_ls_col_es.sh
# --

# --
{
    cat ~/.local/func/ll.d/get_ls_col_es.sh |
    sed '1,3d ; s/_.*=/_col=/g
         s/'"'"'/"${esc}"'"'"'/ ; s/'"'"'$/m'"'"'/' ;
} >> ~/.dotfiles/.local/func/ll.d/get_ls_col_es.sh ; {
    printf '%s\n' '}' >> ~/.dotfiles/.local/func/ll.d/get_ls_col_es.sh ;
}
# --
