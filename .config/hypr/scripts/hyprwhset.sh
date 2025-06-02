#!/usr/bin/env dash
[ -z "${UPID_DIR}" ] && {
    { [ -z "${XDG_RUNTIME_DIR}" ] && exit ; } || UPID_DIR=${XDG_RUNTIME_DIR} ;
}

# --
shName="$(basename "${0}")"
[ "${1}" = "local" ] && {
    summeryLocal='Setting wallpaper from local' ;
}
[ ! "${1}" = "local" ] && {
    summeryWh='Setting wallpaper from WH' ;
}
# --

# --
type notify-send || { printf '%s\n' "notify-send is missing" ; exit 1 ; }
type shasum curl jq hyprctl hyprpaper || {
    notify-send -u critical -w -a "${shName}" \
    "${summeryLocal:-${summeryWh}}" \
    "missing dependencies check the script and your \$PATH" ;
    exit 1 ;
}
nsDelay='500'
hyprPConf="$(realpath "${HOME}"'/.config/hypr/hyprpaper.conf')"
[ ! -f "${hyprPConf}" ] && {
    notify-send -u critical -w -a "${shName}" \
    "${summeryLocal:-${summeryWh}}" \
    'no hyprpaper.conf, needed for setting the wallpaper at startup
that was last set' ;
    exit 1 ;
}
# --

# --
proper_ls () {
    _searchDir="${1}" ;
    {
        _searchRegX="$(printf '%s' "${2}")" ;
        [ -n ${_searchDir} ] && {
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
get_wh_image_url () {
    _keyDir="${HOME}/.config/hypr/whkey"
    _api="https://wallhaven.cc/api/v1/search?" _k="$(cat "${_keyDir}")" ;
    _kW="" _c=110 _p=110 _s=random _aL=1920x1080 _r=landscape ;
    _col=''
    _part="${_api}apikey=${_k}&q=${_kW}&categories=${_c}&purity=${_p}&"
    _apiUrl="${_part}sorting=${_s}&atleast=${_aL}&ratios=${_r}&colors=${_col}" ;
    _apiCurl="$({ curl -sS -m 10 --retry 2 --retry-delay 3 \
        --retry-max-time 20 "${_apiUrl}" ;
    })" ;
    echo "${_apiCurl}" | jq -r '[.data[] | .path] | .[0]' ;
    unset _keyDir _api _k _kW _c _p _s _aL _col \
        _r _part _apiUrl _apiCurl ;
    return 0 ;
}
# --

# --
get_rand_wp_from_local_dir () {
    _min="1" ;
    _nlFList=$(find ~/Pictures/wallpapers/ -type f -print0 | tr '\0\n' '\n\0') ;
    _totFiles=$(printf '%s' "${_nlFList}" | wc -l) ;
    _max="${_totFiles}" ;
    _number=$(($(od -An -N4 -tu /dev/urandom)${_min+%(${_max+$_max- }$_min+1)${_max++$_min}})) ;
    { 
        printf '%s' "${_nlFList}" |
        tr '\0\n' '\n\0' |
        cut -d "$(printf '\0')" -f "${_number}" ;
    } 2>/dev/null ;
    unset _min _max _nlFList _totFiles _number ;
    return 0 ;
}
# --

# --
update_hypr_conf () {
    _hyprPConf="${1}"
    _wpFilePSed="$(printf '%s' "${2}" | sed 's/\//\\\//g')"
    _wpFilePSed="${_wpFilePSed#*/*/*/}"

    {
        grep '^preload = ~' "${_hyprPConf}" &&
        grep '^wallpaper = .* ~' "${_hyprPConf}" ;
    } > /dev/null 2>&1 || {
        notify-send -u critical -w -a "${shName}" \
        "${summeryLocal:-${summeryWh}}" \
        'setup config file so it can be updated use ~ instead of /home/<user>/ for preload and wallpaper' ;
        exit 1 ;
    }
cat <<_HD_hyprPConf > ${_hyprPConf}
$(sed 's/~\/.*$/~\/'"${_wpFilePSed}"'/' "${_hyprPConf}")
_HD_hyprPConf
    unset _wpFilePSed _hyprPConf ; return 0 ;
}
# --

# --
nsId=$(notify-send -t 60000 -u normal -p -a "${shName}" \
"${summeryLocal:-${summeryWh}}" \
'Loading...')
mpvPdPid="$(cat "${UPID_DIR}"/mpvpaper_d.sh.d/pid)" ;
hyprPPid="$(cat "${XDG_RUNTIME_DIR}"/hyprpaper.lock)" ;
# --

# --
{ kill -0 "${mpvPdPid}" && kill -TERM "${mpvPdPid}" ; } 2>/dev/null
! kill -0 "${hyprPPid}" && { setpgid dash -c 'hyprpaper' & }
# --

# --
[ "${1}" = "local" ] && {
    localWp="$(get_rand_wp_from_local_dir)" ;
    update_hypr_conf "${hyprPConf}" "${localWp}" ;
    hyprctl hyprpaper reload ,"${localWp}" ;
    notify-send -w -u normal -t "${nsDelay}" -r "${nsId}" -a "${shName}" \
        "${summeryLocal}" \
        'Done' ; exit 0 ;
}
[ -z "${1}" ] && {
    flush_wp ;
    image_url=$(get_wh_image_url) ;
    wp="${HOME}"/.bg."${image_url##*.}" ;
    curl -s "${image_url}" -o "${wp}" ;
    update_hypr_conf "${hyprPConf}" "${wp}" ;
    hyprctl hyprpaper reload ,"${wp}" ;
    notify-send -w -u normal -t "${nsDelay}" -r "${nsId}"  -a "${shName}" \
        "${summeryWh}"\
        'Done' ;
} ; exit 0
# --
