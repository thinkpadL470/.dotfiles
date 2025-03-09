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
