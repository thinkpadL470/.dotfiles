#!/bin/bash
[ -e ~/.config/pacman/pacman.conf.template ] &&
  cp -L ~/.config/pacman/pacman.conf.template ~/.config/pacman/pacman.conf &&
    sed -i 's|\${HOME}|'"${HOME}"'|g' ~/.config/pacman/pacman.conf

[ -e ~/.config/tofi/config.template ] &&
  [ -e /usr/share/fonts/TTF/FiraCodeNerdFontMono-Regular.ttf ] &&
    fontc="/usr/share/fonts/TTF/FiraCodeNerdFontMono-Regular.ttf" ||
    fontc="sans"
  cp -L ~/.config/tofi/config.template ~/.config/tofi/config &&
    sed -i 's|\${HOME}|'"${HOME}"'|g ; s|\${fontc}|'"${fontc}"'|g' ~/.config/tofi/config
