#!/bin/dash
min_num=${1}
step_count=${2}
max_num=$(( ${3} + ${2} ))
while [ "${min_num}" -lt "${max_num}" ]
do
    printf '%s\n' "${min_num}"
    min_num=$(( ${min_num} + ${step_count} ))
done
