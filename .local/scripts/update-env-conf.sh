#!/bin/bash
test -e ~/.config/pacman/pacman.conf.template && \
  cp -L ~/.config/pacman/pacman.conf.template ~/.config/pacman/pacman.conf && \
  printenv | sed 's|=.*||' | while read subvar ; do
    sed -i "s|\${$subvar}|${!subvar}|g" ~/.config/pacman/pacman.conf ;
  done
  
test -e ~/.config/lf/lfrc.template && \
  export pruned="$(cat ~/.config/find/pruned | tr '\n' ' ')" && \
  cp -L ~/.config/lf/lfrc.template ~/.config/lf/lfrc && \
  printf 'HOME\npruned\n' | while read subvar ; do
    sed -i "s|\${$subvar}|${!subvar}|g" ~/.config/lf/lfrc ;
  done
