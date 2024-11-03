[ -e ~/.config/pacman/pacman.conf.template ] &&
  cp -L ~/.config/pacman/pacman.conf.template ~/.config/pacman/pacman.conf &&
    sed -i 's|\${HOME}|'"${HOME}"'|g' ~/.config/pacman/pacman.conf
