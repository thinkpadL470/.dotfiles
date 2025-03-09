sed_remove_size_for_dirs_and_links () {
    sed \
    -e '\q^'"${esc%*[}"'\['"${di_es}"'q s/'"${esc%*[}"'\['"${z_es}"'.*$//g' \
    -e '\q^'"${esc%*[}"'\['"${ln_es}"'q s/'"${esc%*[}"'\['"${z_es}"'.*$//g' \
    -e 's/\ ../\ / ; s/\ ..-/'"${mh_col}"'&/ ; s/$/'"${nocolor}"'/g' ;
}
