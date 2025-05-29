#!/usr/bin/env dash
set -x
[ -z "${UPID_DIR}" ] && {
    { [ -z "${XDG_RUNTIME_DIR}" ] && exit ; } || UPID_DIR=${XDG_RUNTIME_DIR} ;
}

# --
type shasum mpv mpvpaper hyprpaper hyprctl mpvpaper_d.sh || exit 1
mpvPDaemon='mpvpaper_d.sh'
hyprPConf="$(realpath "${HOME}"'/.config/hypr/hyprpaper.conf')"
[ ! -f "${hyprPConf}" ] && exit 1
lfInput="${f}"
# --

# --
mpvPShPath="$(x="$(hash -r ; type mpvpaper_d.sh)" x="${x##* }" ; printf '%s' "${x}")"
. /dev/stdin <<EOF
$(grep '^shFPath' "${mpvPShPath}" | sed 's/^.*=/mpvPShVar=/ ; s/shName/mpvPDaemon/')
EOF
[ ! "${mpvPShPath}" = "${mpvPShVar}" ] && exit 1
# --

# --
proper_ls () {
    _searchDir="${1}" ;
    {
        _searchRegX="$(printf '%s' "${2}")" ;
        [ -n "${_searchDir}" ] && {
            find "${_searchDir}" \
            ! \( -path "${_searchDir}"'/*/*' -prune \) \
            -type f -name "${_searchRegX}" ;
        } ;
    } ; unset _searchDir _searchRegX _name ; return 0 ;
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
            _newFName="${_fileShasum}-${_wpFile##*/}"
            mv "${_wpFile}" "${_traDir}"/"${_wpFilep}"/"${_newFName}"
        done ; unset _traDir _wpFilep _wpFile _fileShasum ; return 0 ;
}
# --

# --
update_hypr_conf () {
    _hyprPConf="${1}"
    _wpFilePSed="$(printf '%s' "${2}" | sed 's/\//\\\//g')"
    _wpFilePSed="${_wpFilePSed#*/*/*/}"

cat <<EOF > "${_hyprPConf}"
$(sed 's/~\/.*$/~\/'"${_wpFilePSed}"'/' "${_hyprPConf}")
EOF

    unset _wpFilePSed _hyprPConf ; return 0 ;
}
# --

# --
printf '%s\n' mp4 mkv m4v webm qt avi mov flv |
    grep -x "${lfInput##*.}" && wpApplication='mpvpaper'
printf '%s\n' jpg jpeg png jpg2 tif tiff |
    grep -x "${lfInput##*.}" && wpApplication='hyprpaper'
mpvPdPid="$(cat "${UPID_DIR}"/mpvpaper_d.sh.d/pid || true)"
hyprPPid="$(cat "${XDG_RUNTIME_DIR}"/hyprpaper.lock || true)"
# --

# --
wp=~/.bg.
[ "${wpApplication}" = 'hyprpaper' ] && {
    { kill -0 "${mpvPdPid}" && kill -TERM "${mpvPdPid}" ; } || true ;
    { ! kill -0 "${hyprPPid}" && setpgid dash -c 'hyprpaper' & } || true ;
    update_hypr_conf "${hyprPConf}" "${lfInput}" ;
    hyprctl hyprpaper reload ,"${lfInput}" & exit 0 ;
}
[ "${wpApplication}" = 'mpvpaper' ] && {
    { kill -0 "${hyprPPid}" && kill -TERM "${hyprPPid}" ; } || true ;
    flush_wp ;
    cp "${lfInput}" "${wp}${lfInput##*.}" ;
    setpgid dash "${mpvPShPath}" "${wp}${lfInput##*.}" & exit 0 ;
}
# --
