choose_ip () {
    local netipa=$({
        ip a |
        sed '/\(\ lo\|inet6\)/d' |
        grep inet |
        cut -d ' ' -f '6' |
        head -n1 ;
    }) ;
    local ips_to_test=$(printf "${netipa%.*}.%s\n" $(pseq 1 1 254 | tr '\n' ' ')) ;
    local avalible_ips=$({
        for ip in ${ips_to_test}
        do
            ping -c 1 -W 1 ${ip} 2>/dev/null | grep "64 bytes" &
        done |
        cut -d ' ' -f '4' | tr -d ':' ;
    }) ;
    [ -z "${target_hostname}" ] && {
        local network_ip_list=$(printf '%s\n' "${avalible_ips}" | nl -n ln -s' ' | tr -s ' ') ;
        local number_of_ips=$(printf '%s\n' "${network_ip_list}" | wc -l) ;
        printf '%s\n%s\n%s' "${network_ip_list}" \
            "target host not specified" \
            "${sh_name}: choose_ip: select target host: "
        while true
        do
            read selection
            [ "${selection}" -eq "${selection}" ] &&
                [ "${selection}" -gt 0 ] &&
                [ "${selection}" -le "${number_of_ips}" ] &&
                break || {
                    printf '%s\n%s\n' \
                        "${sh_name}: choose_ip: index ${selection} is higer than index max ${number_of_ips} " \
                        "select a valid number in the index of the ips" ;
                    printf '%s\n%s\n' "${network_ip_list}" \
                        "${sh_name}: choose_ip: select target host: " ;
                } ;
        done ;
        local chosen_hostname=$(printf '%s\n' "${network_ip_list}" | sed -n ''"${selection}"'p') ;
        target_hostname="${chosen_hostname##* }" ;
        return 0 ;
    } ;
}
