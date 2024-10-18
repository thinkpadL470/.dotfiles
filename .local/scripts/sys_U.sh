#!/bin/bash
doas pacman -Syyu --config "$PACMCONF" ;
pacman -Qqe > ~/.config/pacman/pkglist.txt ;
pacman -Qqm > ~/.config/pacman/pkglist_m.txt ;
pipx upgrade-all --skip fabric ;
