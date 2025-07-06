#!/usr/bin/env dash
gapall=$({
    hyprctl getoption general:"${1}" |
    grep type | tr -d '[a-z][A-Z]:' |
    tr -s ' ' | cut -d' ' -f'2,3' ;
})

gapy=$(printf '%s' "${gapall}" | cut -d' ' -f'1')
gapx=$(printf '%s' "${gapall}" | cut -d' ' -f'2')
[ "${2}" = "-ymod" ] && gapy=$((gapy - ${3}))
[ "${2}" = "+ymod" ] && gapy=$((gapy + ${3}))
[ "${2}" = "-xmod" ] && gapx=$((gapx - ${3}))
[ "${2}" = "+xmod" ] && gapx=$((gapx + ${3}))
hyprctl keyword general:"${1}" "${gapy},${gapx}" ; exit
