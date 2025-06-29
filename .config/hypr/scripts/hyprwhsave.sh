#!/usr/bin/env dash

# --
shName="$(basename "${0}")"
[ ! "${1}" = "local" ] && {
    summeryWhSave='save current wallpaper' ;
}
nsDelay='500'
type notify-send || { printf '%s\n' "notify-send is missing" ; exit 1 ; }
type shasum hyprpaper || {
    notify-send -u critical -w -a "${shName}" \
    "${summeryWhSave}" \
    "missing dependencies check the script and your \$PATH" ;
    exit 1 ;
}
hyprPConf="$(realpath "${HOME}"'/.config/hypr/hyprpaper.conf')"
[ ! -f "${hyprPConf}" ] && {
    notify-send -u critical -w -a "${shName}" \
    "${summeryLocal:-${summeryWh}}" \
    'no hyprpaper.conf, needed for getting the currently set wallpaper' ;
    exit 1 ;
}
# --

# --
mkdir_folders_inseq () {
    _firstDir="${1}" ;
    _endDir="${2}/" ;
    _dirSeqence=$({
        until [ "${_firstDir}" = "${_endDir}" ]
        do
            _endDirItem="${_endDir%/*}"
            printf '%s\n' "${_endDirItem}"
        done | sort ;
    }) ;
    {
        printf '%s\n' "${_dirSeqence}" |
        while IFS= read -r _item ; do mkdir -m 700 "${_item}" ; done ;
    } 2>/dev/null ;
    [ -d "${_endDir}" ] && return 0 || return 1 ;
}
# --

# --
proper_ls () {
    _searchDir="${1}" ;
    {
        _searchRegX="$(printf '%s' "${2}")" ;
        [ -n "${_searchDir}" ] && {
            find ${_searchDir} \
            ! \( -path "${_searchDir}"'/*/*' -prune \) \
            -type f -name "${_searchRegX}" ;
        } ;
    } ; unset _searchDir _searchRegX _name ; return 0 ;
}
# --

# --
wpDir="${HOME}"/Pictures/wallpapers
[ ! -d "${wpDir}" ] || [ ! -d "${wpDir}".orig.shasums ] && {
    mkdir_folders_inseq "${wpDir%/*}" "${wpDir}" > /dev/null 2>&1 ;
    mkdir_folders_inseq "${wpDir%/*}" "${wpDir}.orig.shasums" > /dev/null 2>&1 ;
    [ -d "${wpDir}" ] || [ -d "${wpDir}".orig.shasums ] || {
        notify-send -u critical -w -a "${shName}" \
        "${summeryWhSave}" \
        "faild to create wallpaper directory for saving" ;
        exit 1 ;
    } ;
}
currentWp="${HOME}""$(grep '^wallpaper' "${hyprPConf}" | cut -d'~' -f2)"
currentWpExt="${currentWp##*.}"
currentWpShasum="$(shasum -U -a 256 "${currentWp}" | cut -d' ' -f1)"
saveFile="${wpDir}"'/WP-'"${currentWpShasum}"'-.'"${currentWpExt}"
# --

# --
nsSaveId=$(notify-send -w -u normal -t "${nsDelay}" -p -a "${shName}" \
    "${summeryWhSave}" \
    'attempting to save...')
[ ! -f "${currentWp}" ] && {
    notify-send -w -u critical -t 5000 -r "${nsSaveId}" -u critical -a "${shName}" \
    "${summeryWhSave}" \
    'no applicable wallpaper exists' ; exit 1 ;
}
[ -z "${currentWpExt}" ] && {
    notify-send -w -u critical -t 5000 -r "${nsSaveId}" -u critical -a "${shName}" \
    "${summeryWhSave}" \
    'file dose not have a extention' ; exit 1 ;
}
proper_ls "${wpDir}.orig.shasums/ ${wpDir}/" "*" | grep "${currentWpShasum}" && {
    notify-send -w -u low -t 5000 -r "${nsSaveId}" -a "${shName}" \
    "${summeryWhSave}" \
    'wallpaper alredy saved' ; exit 1 ;
} ;
cp "${currentWp}" "${saveFile}" ; saveExitState=${?} ;
[ "${saveExitState}" -lt 1 ] && {
    notify-send -w -u normal -t 5000 -r "${nsSaveId}" -a "${shName}" \
    "${summeryWhSave}" \
    "save successfull, saved to ${saveFile}" ; exit 0 ;
} ;
[ "${saveExitState}" -gt 0 ] && {
    notify-send -w -u critical -t 5000 -r "${nsSaveId}" -a "${shName}" \
    "${summeryWhSave}" \
    'wallpaper faild saveing' ; exit 1 ;
} ;
# --
