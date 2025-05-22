#!/usr/bin/env dash
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
kill_paper_services () {
    [ -s "${XDG_RUNTIME_DIR}"/mpvpaper_d.pid ] && {
        until [ -z "${UPID_DIR}/mpvpaper_d.pid" ]
        do
            kill -TERM $(cat ${UPID_DIR}/mpvpaper_d.pid) ;
    [ -s "${UPID_DIR}"/hyprpaper.lock ] &&
        kill -TERM $(cat ${UPID_DIR}/hyprpaper.lock) ;
    return 0 ;
}
# --

# -- vars: wallpaper no ext, what is running?, define hyprpaper conf, generate config
wp=~/.bg.

    # -- check if file is a video and set application
    cat ~/.config/mime/video.txt | grep -x "${f##*.}" && wp_application='mpvpaper'
    cat ~/.config/mime/image.txt | grep -x "${f##*.}" && wp_application='hyprpaper'
    # --
sh_d="${HOME}/.local/scripts"
# --

# -- set selected lf file as wallpaper file and kill running wallpaper services 
flush_wp
cp "${f}" "${wp}${f##*.}"
kill_paper_services
# --

# -- run wallpaper service
[ "${wp_application}" = 'hyprpaper' ] && {
    hyprctl hyprpaper reload ,"${wp}${f##.}" & exit ;
}
[ "${wp_application}" = 'mpvpaper' ] && {
    setpgid dash ${sh_d}/mpvpaper_d.sh "${wp}${f##.}" & exit ;
}
# --
