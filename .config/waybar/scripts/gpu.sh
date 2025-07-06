#!/usr/bin/env dash

[ "${1}" = "clock" ] && {
    output=$({
        nvidia-smi \
            --query-gpu=utilization.gpu \
            --format="csv,noheader,nounits" ;
    }) ;
}

[ "${1}" = "memory" ] && {
    output=$({
        mem_total=$({
            nvidia-smi --query-gpu=memory.total --format="csv,noheader,nounits" ;
            exit ;
        }) ;
        mem_available=$({
            nvidia-smi --query-gpu=memory.free --format="csv,noheader,nounits" ;
            exit ;
        }) ;
        mem_used=$((mem_total - mem_available)) ;
        usage_percentage=$(((mem_used * 100)/mem_total)) ;
        printf '%s' "${usage_percentage}" ; exit ;
    }) ;
}

text="${output}"
[ "${1}" = "clock" ] && tooltip='GPUclock: '"${output}"'%'
[ "${1}" = "memory" ] && tooltip='GPUmemory: '"${output}"'%'
printf '%s' "{\"text\": \"${text}\", \"tooltip\": \"${tooltip}\", \"percentage\": ${output}}"
