#/bin/dash
set -x
[ -e ~/.bg.jpg ] && wpext=jpg
[ -e ~/.bg.png ] && wpext=png
savewp () {
  cp ~/.bg.${wpext} ~/Pictures/wallpapers/WP-$(date +%y-%b-%d-%H-%M-%S).${wpext} &&
    notify-send -t 2000 "hyprwhsave" 'wallpaper saved' ||
    notify-send -t 2000 "hyprwhsave" 'wallpaper faild saveing'
}
# [EXEC]
[ -n "${wpext}" ] && savewp || notify-send -t 2000 "hyprwhsave" 'no applicable wallpaper exists' ; exit
