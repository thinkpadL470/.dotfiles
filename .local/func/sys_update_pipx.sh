[ ! -d "${HOME}/.config/pipx" ] &&
    mkdir ${HOME}/.config/pipx ;
[ -d ~/.config/pipx ] && pipx upgrade-all --skip fabric && {
    pipx list |
    grep package |
    cut -d ' ' -f '5' > ~/.config/pipx/pipxpkgslist.txt ;
}
[ ! -d "${HOME}/.config/pipx" ] && {
    printf '%s\n' "no pipx config dir" ;
    exit 1 ;
}
