{
    ${auth} pacman -Syyu --config "${HOME}/.config/pacman/pacman.conf" && {
        [ ! -d ~/.config/pacman ] && mkdir ~/.config/pacman ;
        [ -d ~/.config/pacman ] && {
            pacman -Qqe > ~/.config/pacman/pkglist.txt &&
            pacman -Qqm > ~/.config/pacman/pkglist_m.txt ;
        };
    };
}
