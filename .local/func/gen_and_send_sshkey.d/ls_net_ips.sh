[ -z "${target_hostname}" ] && {
    network_ip_list=$(${sh_d}/get_ips_in_current_network.sh | nl -n ln -s' ' | tr -s ' ') ;
    number_of_ips=$(printf '%s\n' "${network_ip_list}" | wc -l) ;
    {
        printf '%s\n%s\n%s' "${network_ip_list}" \
            "target host not specified" \
            "select target host: " ;
        while true
        do
            read selection
            [ "${selection}" -eq "${selection}" ] &&
                [ "${selection}" -gt 0 ] &&
                [ "${selection}" -le "${number_of_ips}" ] &&
                break || {
                printf '%s\n%s\n' \
                "index ${selection} is higer than index max ${number_of_ips} " \
                "select a valid number in the index of the ips" ;
                    printf '%s\n%s\n' "${network_ip_list}" \
                        "select target host: " ;
                }
        done ;
    };
    chosen_hostname=$(printf '%s\n' "${network_ip_list}" | sed -n ''"${selection}"'p') ;
    target_hostname=${chosen_hostname##* } ;
}
