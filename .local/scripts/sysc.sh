#!/bin/bash
pacman -Qtdq > ~/.config/pacman/syscpkglist.txt ;
doas pacman -Rns $(pacman -Qtdq) ;
doas pacman -Sc ;
trash-empty 14 ;
