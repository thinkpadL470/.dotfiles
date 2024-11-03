${auth} pacman -Syyu --config "${PACMCONF}" &&
  [ ! -d ~/.config/pacman ] && mkdir ~/.config/pacman
  [ -d ~/.config/pacman ] &&
    pacman -Qqe > ~/.config/pacman/pkglist.txt &&
    pacman -Qqm > ~/.config/pacman/pkglist_m.txt
