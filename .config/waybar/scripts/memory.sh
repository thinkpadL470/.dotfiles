#!/usr/bin/env dash

[ "${1}" = "real" ] && {
    used_percentage=$({
        mem_total=$({
            grep 'MemTotal' /proc/meminfo |
            tr -s ' ' |
            cut -s -d' ' -f'2' ; exit ;
        }) ;
        mem_available=$({
            grep 'MemAvailable' /proc/meminfo |
            tr -s ' ' |
            cut -s -d' ' -f'2' ; exit ;
        }) ;
        mem_used=$((mem_total - mem_available)) ;
        usage_percentage=$(((mem_used * 100)/mem_total)) ;
        printf '%s' "${usage_percentage}" ; exit ;
    })
}
[ "${1}" = "swap" ] && {
    used_percentage=$({
        mem_total=$({
            grep 'SwapTotal' /proc/meminfo |
            tr -s ' ' |
            cut -s -d' ' -f'2' ; exit ;
        }) ;
        mem_available=$({
            grep 'SwapFree' /proc/meminfo |
            tr -s ' ' |
            cut -s -d' ' -f'2' ; exit ;
        }) ;
        mem_used=$((mem_total - mem_available)) ;
        usage_percentage=$(((mem_used * 100)/mem_total)) ;
        printf '%s' "${usage_percentage}" ; exit ;
    })
}
text="${used_percentage}"
printf "{\"text\": \"${text}\", \"percentage\": ${used_percentage}}"
