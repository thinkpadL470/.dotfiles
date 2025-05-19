#!/usr/bin/env dash
gaps=$(hyprctl getoption general:"${1}" | grep type | tr -d '[a-z][A-Z]:' | tr -s ' ' | cut -d' ' -f'2')
[ "${2}" = "-mod" ] && gaps=$((gaps - ${3}))
[ "${2}" = "+mod" ] && gaps=$((gaps + ${3}))
hyprctl keyword general:"${1}" $gaps ; exit
