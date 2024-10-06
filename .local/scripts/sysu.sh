#!/bin/bash
pacman --config 
doas pacman -Syyu --config "$PCCONF" ;
pacman -Qqe > ~/.config/pacman/pkglist.txt ;
pacman -Qqm > ~/.config/pacman/pkglist_m.txt ;
pipx upgrade-all --skip fabric ;
