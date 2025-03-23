#!/usr/bin/env dash
get_image_fmt () {
    local input=${1} ;
    local file_out=$(file ${input} 2>&1) ;
    printf '%s' "${file_out}" | grep -e 'JPEG' && printf '%s' "JPEG" && return 0 ;
    printf '%s' "${file_out}" | grep -e 'PNG' && printf '%s' "PNG" && return 0 ;
    printf '%s' "${file_out}" | grep -e 'empty' && printf '%s' "empty" && return 0 ;
}
fd_b=$(type fd)
[ -x "${fd_b##* }" ] &&
    cmd () { ${fd_b##* } -t f -e jpg -e png . ./ ; } ||
        cmd () { find ./ -type f -iname '*.png' -o -iname '*.jpg' ; }
cmd | while IFS= read -r file
do
    image_format=$(get_image_fmt ${file})
    original_extention=${file##*.}
    [ "${image_format}" = "PNG" ] && new_extention=png
    [ "${image_format}" = "JPEG" ] && new_extention=jpg
    [ ! "${original_extention}" = "${new_extention}" ] && {
        mv ${file} ${file%.*}.${new_extention} ;
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
        ~/.local/bin/del ${file} || rm ${file} ;
    };
done ; exit 0
