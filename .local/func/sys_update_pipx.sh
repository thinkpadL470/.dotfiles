[ -x /bin/pipx ] && {
    [ ! -d "${HOME}/.config/pipx" ] &&
        mkdir ${HOME}/.config/pipx ;
    [ -x /usr/bin/pipx -a -d ~/.config/pipx ] && pipx upgrade-all --skip fabric && {
        pipx list |
        grep package |
        sed 's/\ \ \ //g' |
        cut -d ' ' -f '2' > ~/.config/pipx/pipxpkgslist.txt ;
    };
}
[ ! -x /bin/pipx ] && {
    printf '%s\n' "pipx not installed" ;
    exit 1 ;
}
[ ! -d "${HOME}/.config/pipx" ] && {
    printf '%s\n' "no pipx config dir" ;
    exit 1 ;
}
