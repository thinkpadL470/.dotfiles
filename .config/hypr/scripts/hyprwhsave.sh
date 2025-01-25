#!/usr/bin/dash
# -- look for wallpaper in home dir
current_wp=$(ls -1 .bg.* | head -n1)
wpext=${current_wp##*.}
# --

# -- save the wallpaper
[ -n "${wpext}" ] && {
    { [ ! -d "${HOME}/Pictures/wallpapers" ] &&
        mkdir -p ${HOME}/Pictures/wallpapers ;
    };
    cp ${HOME}/.bg.${wpext} ${HOME}/Pictures/wallpapers/WP-$(date +%y-%b-%d-%H-%M-%S).${wpext} &&
    notify-send -t 2000 "hyprwhsave" 'wallpaper saved' ||
    notify-send -t 2000 "hyprwhsave" 'wallpaper faild saveing' ;
} || {
    notify-send -t 2000 "hyprwhsave" 'no applicable wallpaper exists' ;
    exit 1 ;
}
# --
