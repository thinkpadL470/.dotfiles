#!/usr/bin/env dash
two_column_var=${1}
total_column_width=$(
    for string_on_line in ${two_column_var}
    do
        lhs_string_on_line="${string_on_line%+*}"
        printf '%s\n' "${#lhs_string_on_line}"
    done |
    sort -n | tail -n1
)
for line in ${two_column_var}
do
    printf \
        '%-'"${total_column_width}"'s    %s\n' \
        "${line%+*}" "${line#*+}"
done
