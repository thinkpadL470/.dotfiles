#!/usr/bin/env dash
. ${HOME}/.local/func/define_script_directories_in_variables.sh
# -- set variables
hyprsh="${HOME}/.config/hypr/scripts"
hyprpc="${HOME}/.config/hypr/hyprpaper.conf"
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
hpconfig=$({ printf '%s\n%s\n%s\n' \
    "preload = ${wp} " \
    "wallpaper = , ${wp} " \
    "splash = false" ;
})
# --

# -- kill running wallpaper services, append config and run hyprpaper
. ${fu_d}/flushwp.sh
[ -s "${UPID_DIR}/mpvpaper_d.pid" ] &&
    kill -15 $(cat ${UPID_DIR}/mpvpaper_d.pid)
[ -s "${UPID_DIR}/hyprpaper_d.pid" ] &&
    kill -15 $(cat ${UPID_DIR}/hyprpaper_d.pid)
curl -s ${image_url} > ${wp}
printf '%s\n' "${hpconfig}" > ${hyprpc}
setpgid dash ${hyprsh}/hyprpaper_d.sh & exit 0
# --
