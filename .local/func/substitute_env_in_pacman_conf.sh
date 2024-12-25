~/.local/func/define_script_directories_in_variables.sh
main_file="${HOME}/.config/pacman/pacman.conf"
[ -e "${main_file}.template" ] && {
    cat ${main_file}.template > ${main_file} ;
    temp_var_main_file=$(cat ${main_file}) ;
    {
        printf '%s\n' "${temp_var_main_file}" |
        sed 's|\${HOME}|'"${HOME}"'|g' > ${main_file} ;
    } ; unset temp_var_main_file ;
}
[ ! -e "${main_file}.template" ] && ${fu_d}/no_template_file.sh
