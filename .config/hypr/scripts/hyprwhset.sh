#!/usr/bin/dash
. ${HOME}/.local/func/define_script_directories_in_variables.sh
# -- set variables
hyprpapc="${HOME}/.config/hypr/hyprpaper.conf"
pid_hyprpaper=$(ps -a -o "pid comm" | grep hyprpaper | tr -cd '0-9')
pid_mpvpaper=$(ps -a -o "pid comm" | grep mpvpaper | tr -cd '0-9')
# --

# -- Get Image url
api="https://wallhaven.cc/api/v1/search?"
key="$(cat ~/.config/hypr/whkey)"
    q= categories=110
    purity=110 sorting=random
    atleast=1920x1080 ratios=landscape
api_url="${api}apikey=${key}&q=${keywords}&categories=${categories}&purity=${purity}&ratios=${ratios}&sorting=${sorting}"
api_curl=$(curl -sS --max-time 10 --retry 2 --retry-delay 3 --retry-max-time 20 "${api_url}")
image_url=$(echo "${api_curl}" | jq -r '[.data[] | .path] | .[0]')
wp="${HOME}/.bg.${image_url##*.}"
# --

# -- Generate config
rconfig=$({ printf '%s\n%s\n%s\n' \
    "preload = ${wp} " \
    "wallpaper = , ${wp} " \
    "splash = false" ;
})
# --

# -- kill running wallpaper services, append config and run hyprpaper
${fu_d}/flushwp.sh
[ -z "${pid_hyprpaper}" -a -z "${pid_mpvpaper}" ] ||
    kill -9 ${pid_hyprpaper} ${pid_mpvpaper} && {
    curl -s ${image_url} > ${wp} ;
    printf '%s\n' "${rconfig}" > ${hyprpapc} ;
    hyprpaper ;
}
# --
