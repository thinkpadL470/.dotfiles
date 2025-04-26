#!/usr/bin/env dash
# -- set variables
set -x
hyprsh="${HOME}/.config/hypr/scripts"
hyprpc="${HOME}/.config/hypr/hyprpaper.conf"
# --

# --
flush_wp () {
    local tra_dir="${HOME}/.local/share/graveyard" ;
    [ ! -d "${tra_dir}" ] && mkdir -p ${tra_dir} ;
    ls -1 ${HOME}/.bg.* |
        while IFS= read -r wpfile
        do
            wpfilep=${wpfile%/*}
            mkdir -p ${tra_dir}/${wpfilep}
            mv ${wpfile} ${tra_dir}/${wpfilep}$(date +%y-%b-%d-%H-%M-%S)${wpfile##*/}
        done ;
    return 0 ;
}
# --

# --
get_wh_image_url () {
    local api="https://wallhaven.cc/api/v1/search?" ;
    local key="$(cat ~/.config/hypr/whkey)" ;
        local q= categories=110 ;
        local purity=110 sorting=random ;
        local atleast=1920x1080 ratios=landscape ;
    local api_url="${api}apikey=${key}&q=${keywords}&categories=${categories}&purity=${purity}&ratios=${ratios}&sorting=${sorting}" ;
    local api_curl=$(curl -sS --max-time 10 --retry 2 --retry-delay 3 --retry-max-time 20 "${api_url}") ;
    echo "${api_curl}" | jq -r '[.data[] | .path] | .[0]' ;
    return 0 ;
}
# --

# --
gen_hyprp_conf () {
    printf '%s\n%s\n%s\n' \
        "preload = ${wp} " \
        "wallpaper = , ${wp} " \
        "splash = false" ;
    return 0 ;
}
# --

# --
kill_paper_services () {
    [ -s "${UPID_DIR}/mpvpaper_d.pid" ] &&
        kill -TERM $(cat ${UPID_DIR}/mpvpaper_d.pid) ;
    [ -s "${UPID_DIR}/hyprpaper_d.pid" ] &&
        kill -TERM $(cat ${UPID_DIR}/hyprpaper_d.pid) ;
    return 0 ;
}
# --

# --
    image_url=$(get_wh_image_url) ;
    wp="${HOME}/.bg.${image_url##*.}" ;
# --

# --
flush_wp
kill_paper_services
curl -s ${image_url} > ${wp}
printf '%s\n' "$(gen_hyprp_conf)" > ${hyprpc}
setpgid ${hyprsh}/hyprpaper_d.sh & exit
# --
