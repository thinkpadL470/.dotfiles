#!/usr/bin/env dash

# --
type shasum notify-send || exit 1
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
            find "${_searchDir}" \
            ! \( -path "${_searchDir}"'/*/*' -prune \) \
            -type f -name "${_searchRegX}" ;
        } ;
    } ; unset _searchDir _searchRegX _name ; return 0 ;
}
# --

# --
currentWp="$(proper_ls "${HOME}" "*.bg.*" | head -n1)" || exit 1
shName="$(basename "${0}")"
wpExt="${currentWp##*.}"
nsDelay='500'
# --

# --
nsSaveId=$(notify-send -w -u normal -t "${nsDelay}" -p -a "${shName}" \
'save current wallpaper' \
'initializeing...')
[ ! -f "${currentWp}" ] && { notify-send -w -u critical -t 5000 -r "${nsSaveId}" -u critical -a "${shName}" \
    'save current wallpaper' \
    'no applicable wallpaper exists' ; exit 1
}
[ -z "${wpExt}" ] && { notify-send -w -u critical -t 5000 -r "${nsSaveId}" -u critical -a "${shName}" \
    'save current wallpaper' \
    'file dose not have a extention' ; exit 1
}
notify-send -w -u normal -t "${nsDelay}" -r "${nsSaveId}" -a "${shName}" \
'save current wallpaper' \
'attempting to save...'
# --

# --
[ ! -d "${HOME}"/Pictures/wallpapers ] && {
    mkdir_folders_inseq "${HOME}"/Pictures "${HOME}"/Pictures/wallpapers || exit 1 ;
} ;
wpShasum="$(shasum -U -a 256 "${currentWp}" | cut -d' ' -f1)"
wpPath="${HOME}"/Pictures/wallpapers
wpFile="${wpPath}"/WP-"${wpShasum}"-."${wpExt}"
[ -f "${wpFile}" ] && {
    notify-send -w -u low -t 5000 -r "${nsSaveId}" -a "${shName}" \
    'save current wallpaper' \
    'wallpaper alredy saved' ; exit 1 ; 
} ;
cp "${currentWp}" "${wpFile}" ; saveExitState=${?} ;
[ "${saveExitState}" -lt 1 ] && {
    notify-send -w -u normal -t "${nsDelay}" -r "${nsSaveId}" -a "${shName}" \
    'save current wallpaper' \
    'save successfull' ; exit 0 ;
} ;
[ "${saveExitState}" -gt 0 ] && {
    notify-send -w -u critical -t 5000 -r "${nsSaveId}" -a "${shName}" \
    'save current wallpaper' \
    'wallpaper faild saveing' ; exit 1 ;
} ;
# --
