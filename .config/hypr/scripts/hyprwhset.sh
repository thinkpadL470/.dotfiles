#!/bin/dash
# [VARIABLES]
  # [LOCATIONS]
    monn="HDMI-A-1"
    hyprpapc="${HOME}/.config/hypr/hyprpaper.conf"
  # [AUTH]
    key="$(cat ~/.config/hypr/whkey)"
  # [DEFINE_QUALITY]
    api="https://wallhaven.cc/api/v1/search?"
    q=
    categories=110
    purity=110
    sorting=random
    atleast=1920x1080
    ratios=landscape
  # [GETURL]
    api_url="${api}apikey=${key}&q=${keywords}&categories=${categories}&purity=${purity}&ratios=${ratios}&sorting=${sorting}"
    api_curl=$(curl -sS --max-time 10 --retry 2 --retry-delay 3 --retry-max-time 20 "${api_url}")
    image_url=$(echo "${api_curl}" | jq -r '[.data[] | .path] | .[0]')
    wp="${HOME}/.bg.${image_url##*.}"
  # [FUNCTIONS]
    flushwp () {
      for wpfile in $(cd ~ && ls .bg.*)
      do
        cd ~
        mkdir ~/.local/share/graveyard/home
        mv ${wpfile} ~/.local/share/graveyard/home/${wpfile}$(date +%y-%b-%d-%H-%M-%S)
      done
    };
    reloadconf () {
      printf "preload = ${wp} \n wallpaper = ${monn},${wp} \n splash = false \n" > ${hyprpapc}
    };
    defimage() {
      curl -s ${image_url} > ${wp}
    }
# [EXEC]
  flushwp ; [ -z "$(pgrep hyprpaper)" -a -z "$(pgrep mpvpaper)" ] && 
    defimage && reloadconf && hyprpaper ||
    pkill 'hyprpaper|mpvpaper' && defimage && reloadconf && hyprpaper ;
