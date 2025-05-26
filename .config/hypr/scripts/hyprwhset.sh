#!/usr/bin/env dash
[ -z "${UPID_DIR}" ] && {
    { [ -z "${XDG_RUNTIME_DIR}" ] && exit ; } || UPID_DIR=${XDG_RUNTIME_DIR} ;
}

# --
proper_ls () {
    _searchDir="${1}" ;
    {
        [ "${#}" -eq "2" ] && {
            _name="-name" _searchRegX="${2}" ;
        } ;
    } && {
        find "${_searchDir}" \
        ! \( -path "${_searchDir}"'/*/*' -prune \) \
        -type f "${_name}" "${_searchRegX}" ;
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
            _newFName="$(date +%y-%b-%d)-${_fileShasum}-${_wpFile##*/}"
            mv "${_wpFile}" "${_traDir}"/"${_wpFilep}"/"${_newFName}"
        done ; unset _traDir _wpFilep _wpFile _fileShasum ; return 0 ;
}
# --

# --
get_wh_image_url () {
    _keyDir="${HOME}/.config/hypr/whkey"
    _api="https://wallhaven.cc/api/v1/search?" _k="$(cat "${_keyDir}")" ;
    _kW="" _c=110 _p=111 _s=random _aL=1920x1080 _r=landscape ;
    _apiUrl1="${_api}apikey=${_k}&q=${_kW}&categories=${_c}&"
    _apiUrl2="purity=${_p}&sorting=${_s}&atleast=${_aL}&ratios=${_r}" ;
    _apiUrl="${_apiUrl1}${_apiUrl2}"
    _apiCurl="$({ curl -sS -m 10 --retry 2 --retry-delay 3 \
        --retry-max-time 20 "${_apiUrl}" ;
    })" ;
    echo "${_apiCurl}" | jq -r '[.data[] | .path] | .[0]' ;
    unset _keyDir _api _k _kW _c _p _s _aL \
        _r _apiUrl1 _apiUrl2 _apiUrl _apiCurl ;
    return 0 ;
}
# --

# --
kill_paper_services () {
    _mpvPdPid="${UPID_DIR}"/mpvpaper_d.sh.d/pid ;
    # _hyprPPid="${XDG_RUNTIME_DIR}"/hyprpaper.lock ;
    {
        ! kill -0 "${_mpvPdPid}" || kill -TERM "${_mpvPdPid}" ;
        # ! kill -0 "${_hyprPPid}" || kill -TERM "${_hyprPPid}" ;
    } 2>/dev/null ;
    unset _mpvPdPid ; # _hyprPPid ;
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
kill_paper_services
flush_wp
[ "${1}" = "local" ] && {
    local_wp=$(get_rand_wp_from_local_dir) ;
    wp="${HOME}"/.bg."${local_wp##*.}" ;
    cat "${local_wp}" > "${wp}" ;
}
[ -z "${1}" ] && {
    image_url=$(get_wh_image_url) ;
    wp="${HOME}"/.bg."${image_url##*.}" ;
    curl -s "${image_url}" -o "${wp}" ;
}
hyprctl hyprpaper reload ,"${wp}" ; exit 0
# --
