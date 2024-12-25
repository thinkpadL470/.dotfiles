main_file="${HOME}/.config/tofi/config"
[ -e "${main_file}.template" ] && {
    cat ${main_file}.template > ${main_file} ;
    temp_var_main_file=$(cat ${main_file}) ;
    [ -e /usr/share/fonts/TTF/FiraCodeNerdFontMono-Regular.ttf ] && {
        fontc="/usr/share/fonts/TTF/FiraCodeNerdFontMono-Regular.ttf" ||
        fontc="sans" ;
    };
    {
        printf '%s\n' "${temp_var_main_file}" |
        sed 's|\${HOME}|'"${HOME}"'|g
        s|\${fontc}|'"${fontc}"'|g' > ${main_file} ;
    };
    ${fu_d}/no_template_file.sh
    unset temp_var_main_file ;
}
