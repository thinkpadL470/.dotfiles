curl_b_agent="Mozilla/5.0 (Windows NT 10.0; rv:127.0) Gecko/20100101 Firefox/127.0"
curl -A "${curl_b_agent}" "${1}" | {
    tr '"' '\n' |
    tr "'" '\n' |
    grep -e '^https://' -e '^http://' -e '^//' |
    sort |
    uniq ;
}
