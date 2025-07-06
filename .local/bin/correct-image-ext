#!/usr/bin/env dash
get_image_fmt () {
    _inputFile="${1}" ;
    _fmtDesc="$(file "${_inputFile}" 2>&1)" ;
    { printf '%s' "${_fmtDesc}" | grep -e 'JPEG' ; } >/dev/null 2>&1 &&
        printf '%s' "JPEG" && return 0 ;
    { printf '%s' "${_fmtDesc}" | grep -e 'PNG' ; } >/dev/null 2>&1 &&
        printf '%s' "PNG" && return 0 ;
    { printf '%s' "${_fmtDesc}" | grep -e 'empty' ; } >/dev/null 2>&1 &&
        printf '%s' "empty" && return 0 ;
}
fd_b="$(type fd)"
{ [ -x "${fd_b##* }" ] && cmd () { ${fd_b##* } -t f -e jpg -e png . ./ ; } ; } || {
    cmd () { find ./ -type f -name '*.png' -o -name '*.jpg' ; } ;
}
cmd | while IFS= read -r file
do
    image_format="$(get_image_fmt "${file}")"
    original_extention="${file##*.}"
    [ "${image_format}" = "PNG" ] && new_extention=png
    [ "${image_format}" = "JPEG" ] && new_extention=jpg
    [ ! "${original_extention}" = "${new_extention}" ] && {
        mv "${file}" "${file%.*}"."${new_extention}" ;
        status='incorrect' ;
    }
    [ "${original_extention}" = "${new_extention}" ] && {
        status='correct'
    }
    printf '%s\t%s' \
        "${file%.*}.${original_extention}" \
        "has fmt ${image_format} it is ${status}"
    [ "${image_format}" = "empty" ] && {
        printf '%s%s\n' \
            "${file%.*}.${original_extention} " \
            'is corrupt or is a empty file, deleting' ;
        ~/.local/bin/del "${file}" || rm "${file}" ;
    };
done ; exit 0
