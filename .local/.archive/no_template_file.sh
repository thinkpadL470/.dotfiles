[ ! -e "${main_file}.template" ] && {
    printf '%s\n' "no .template for ${main_file}" ;
    unset main_file ;
    exit 1 ;
};
