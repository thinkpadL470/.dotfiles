#!/usr/bin/env dash
. ~/.local/func/define_script_directories_in_variables.sh
netipa=$({
    ip a |
    sed '/\(\ lo\|inet6\)/d' |
    grep inet |
    cut -d ' ' -f '6' |
    head -n1 ;
})
ips_to_test=$(printf "${netipa%.*}.%s\n" $(${bi_d}/pseq 1 1 254 | tr '\n' ' '))
avalible_ips=$({
    for ip in ${ips_to_test}
    do
        ping -c 1 -W 1 $ip 2>/dev/null | grep "64 bytes" &
    done |
    cut -d ' ' -f '4' | tr -d ':' ;
})
printf '%s\n' "${avalible_ips}"
