wp=~/.bg.
hyprpapc=~/.config/hypr/hyprpaper.conf
cp $f ${wp}${f##*.}
[ -z "$(pgrep mpvpaper)" -a -z "$(pgrep hyprpaper)" ] &&
  printf "preload = ${wp}${f##*.}\nwallpaper = HDMI-A-1,${wp}${f##*.}\nsplash = false" > ${hyprpapc} &&
  hyprpaper ||
  pkill 'mpvpaper|hyprpaper' &&
  printf "preload = ${wp}${f##*.}\nwallpaper = HDMI-A-1,${wp}${f##*.}\nsplash = false" > ${hyprpapc} &&
  hyprpaper
