#!/usr/bin/env dash
utopia () {
    export \
        color01='#261c29' \
        color01_70='#261c29b3' \
        color02='#b145d5' \
        color03='#51d5b4' \
        color04='#d4d443' \
        color05='#8eb221' \
        color06='#58b7d6' \
        color07='#a190d9' \
        color07_70='#a190d9b3' \
        color08='#e7bbc6' \
        color09='#666666' \
        color10='#b145d5' \
        color11='#51d5b4' \
        color12='#d4d443' \
        color13='#8eb221' \
        color14='#58b7d6' \
        color15='#a190d9' \
        color16='#9ea5b9' \
        fontc='/usr/share/fonts/TTF/FiraCodeNerdFont-Regular.ttf' \
        gray005='#0D0D0D' \
        gray005_50='#0D0D0D80' \
        gray010='#1A1A1A' \
        gray015='#262626' \
        gray015_70='#2626263b' \
        gray015_50='#26262680' \
        gray020='#333333' \
        gray020_50='#33333380' \
        gray025='#404040' \
        gray025_50='#40404080' \
        gray030='#4D4D4D' \
        gray035='#595959' \
        gray035_50='#59595980' \
        gray040='#666666' \
        gray045='#737373' \
        gray050='#808080' \
        gray050_50='#80808080' \
        gray050_70='#80808080' \
        gray055='#8C8C8C' \
        gray060='#999999' \
        gray065='#A6A6A6' \
        gray070='#B3B3B3' \
        gray075='#BFBFBF' \
        gray080='#CCCCCC' \
        gray085='#D9D9D9' \
        gray090='#E5E5E5' \
        gray095='#F2F2F2' \
        gray100='#FFFFFF' ;
    envsubst -i ~/.dotfiles/.config/tofi/themes/utopia.template -o ~/.config/tofi/themes/utopia
    envsubst -i ~/.dotfiles/.config/tofi/config.template -o ~/.config/tofi/config
}
{
    utopia ;
    unset \
        gray005 gray010 gray015 gray020 gray025 gray030 gray035 \
        gray040 gray045 gray050 gray055 gray060 gray065 gray070 \
        gray075 gray080 gray085 gray090 gray095 gray100 \
        fontc ;
}

# l_cyanA='#84F4F9' \
# l_cyanB='#84B4F9' \
# l_cyanC='#84F9D5' \
# l_magentaA='#E47FF8' \
# l_magentaB='#F87FCA' \
# l_magentaC='#BA7FF8' \
# l_yellowA='#FCEFBE' \
# l_yellowB='#EFFCBE' \
# l_yellowC='#FCD5BE' \
# n_cyanA='#31CCFF' \
# n_cyanB='#315CFF' \
# n_cyanC='#31FFEB' \
# n_magentaA='#FF2DF6' \
# n_magentaB='#FF2D83' \
# n_magentaC='#C02DFF' \
# n_yellowA='#FFFF62' \
# n_yellowB='#BEFF62' \
# n_yellowC='#FFBE62' \
# d_cyanA='#000E80' \
# d_cyanB='#2E0080' \
# d_cyanC='#013C80' \
# d_magentaA='#7E0029' \
# d_magentaB='#7E1300' \
# d_magentaC='#7E0056' \
# d_yellowA='#379400' \
# d_yellowB='#009400' \
# d_yellowC='#779400' \
