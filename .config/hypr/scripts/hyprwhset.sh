#!/usr/bin/env dash
# -- set variables
hyprsh="${HOME}/.config/hypr/scripts"
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
# gen_hyprp_conf () {
#     printf '%s\n%s\n%s\n' \
#         "preload = ${wp} " \
#         "wallpaper = , ${wp} " \
#         "splash = false" ;
#     return 0 ;
# }
# --

# --
kill_paper_services () {
    [ -s "${UPID_DIR}/mpvpaper_d.pid" ] &&
        kill -TERM $(cat ${UPID_DIR}/mpvpaper_d.pid) ;
    [ -s "${XDG_RUNTIME_DIR}/hyprpaper.lock" ] &&
        kill -TERM $(cat ${XDG_RUNTIME_DIR}/hyprpaper.lock) ;
    return 0 ;
}
# --

# --
get_rand_wp_from_local_dir () {
    local min="1" ;
    local nl_f_list=$(find ~/Pictures/wallpapers/ -type f -print0 | tr '\0\n' '\n\0') ;
    local tot_files=$(printf '%s' "${nl_f_list}" | wc -l) ;
    local max="${tot_files}" ;
    local number=$(($(od -An -N4 -tu /dev/urandom)${min+%(${max+$max- }$min+1)${max++$min}})) ;
    { printf '%s' "${nl_f_list}" | tr '\0\n' '\n\0' | cut -d "$(printf '\0')" -f "${number}" ; } 2>/dev/null ;
    return 0 ;
}
# --

# --
kill -0 "${UPID_DIR}"/mpvpaper_d.pid && kill_paper_services || true
flush_wp
[ "${1}" = "local" ] && {
    local_wp=$(get_rand_wp_from_local_dir) ;
    wp="${HOME}"/.bg."${local_wp##*.}" ;
    cat "${local_wp}" > "${wp}" || true ;
}
[ ! "${1}" = "local" ] && {
    image_url=$(get_wh_image_url) ;
    wp="${HOME}"/.bg."${image_url##*.}" ;
    curl -s ${image_url} > ${wp} || true ;
}
hyprctl hyprpaper reload ,$(realpath "${wp}") & exit
# --
