#!/usr/bin/dash
. ${HOME}/.local/func/define_script_directories_in_variables.sh
ls -1 | while IFS= read -r file
do
    {
        image_format=$(file ${file} 2>&1 |
            grep -m 1 -o -e '\(JPEG\|PNG\|empty\)' |
            head -n 1 ;
        );
        original_extention=${file##*.} ;
        {
            [ "${image_format}" = "PNG" ] && new_extention=png ||
            [ "${image_format}" = "JPEG" ] && new_extention=jpg ;
        } &&
        {
            [ ! "${original_extention}" = "${new_extention}" ] &&
                mv ${file} ${file%.*}.${new_extention} ;
                format_to_ext_status='incorrect' ;
            [ "${original_extention}" = "${new_extention}" ] &&
                format_to_ext_status='correct' ;
        } &&
        {
            printf '%s\t%s%s\n' \
                "format is ${image_format}" \
                "and is ${format_to_ext_status} for original file " \
                "${file%.*}.${original_extention}" ;
        };
        [ "${image_format}" = "empty" ] && {
            printf '%s%s\n' \
                "${file%.*}.${original_extention} " \
                'is corrupt or is a empty file, deleting' ;
            ${bi_d}/del ${file} || rm ${file} ;
        };
    }
done ;
