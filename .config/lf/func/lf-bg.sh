#!/usr/bin/env dash
[ -z "${UPID_DIR}" ] && {
    { [ -z "${XDG_RUNTIME_DIR}" ] && exit ; } || UPID_DIR=${XDG_RUNTIME_DIR} ;
}

# --
proper_ls () {
    _searchDir="${1}" ;
    {
        [ "${#}" -eq "1" ] && {
            find "${_searchDir}" \
            ! \( -path "${_searchDir}"'/*/*' -prune \) \
            -type f ;
        } ;
    } || { _searchRegX="${2}" ;
        [ -n "${_searchRegX}" ] && {
            find "${_searchDir}" \
            ! \( -path "${_searchDir}"'/*/*' -prune \) \
            -type f -name "${_searchRegX}" ;
        } ;
    } ;
    unset _searchDir _searchRegX ; return 0 ;
}
# --

# --
flush_wp () {
    _traDir="${HOME}"/.local/share/graveyard ;
    [ ! -d "${_traDir}" ] && mkdir -p "${_traDir}" ;
    proper_ls "${HOME}" "*.bg.*" |
        while IFS= read -r _wpFile
        do
            _wpFilep="${_wpFile%/*}"
            mkdir -p "${_traDir}"/"${_wpFilep}"
            _fileShasum=$(shasum -U -a 256 "${_wpFile}" | cut -d' ' -f1)
            _newFName="$(date +%y-%b-%d)-${_fileShasum}-${_wpFile##*/}"
            mv "${_wpFile}" "${_traDir}"/"${_wpFilep}"/"${_newFName}"
        done ; unset _traDir _wpFilep _wpFile _fileShasum _newFName ;
        return 0 ;
}
# --

# --
kill_paper_services () {
    _mpvPdPid="${UPID_DIR}"/mpvpaper_d.sh.d/pid ;
    _hyprPPid="${XDG_RUNTIME_DIR}"/hyprpaper.lock ;
    {
        ! kill -0 "${_mpvPdPid}" || kill -TERM "${_mpvPdPid}" ;
        ! kill -0 "${_hyprPPid}" || kill -TERM "${_hyprPPid}" ;
    } 2>/dev/null ;
    unset _mpvPdPid _hyprPPid ;
    return 0 ;
}
# --

# --
wp=~/.bg.
# --

# --
printf '%s\n' mp4 mkv m4v webm qt avi mov flv |
    grep -x "${f##*.}" && wp_application='mpvpaper'
printf '%s\n' jpg jpeg png jpg2 tif tiff |
    grep -x "${f##*.}" && wp_application='hyprpaper'
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
