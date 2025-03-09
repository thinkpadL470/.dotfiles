sed_color_format_ls_output () {
    sed '1d
    s/\ /\t/ ; s/\ /\t/3 ; s/\t.*\t/\t/ ; s/\ /_/2
    s/\ /\ \t/2 ; s/\ /\ \t/3 ; s/\ \t.*\ \t/\t/ ; s/\ /\t/
    s/^l/'"${ln_col}"'l/ ; s/^d/'"${di_col}"'d/ ; s/^-/'"${mh_col}"'-/
    s/r--/'"${mh_col}"'4/g ; s/-w-/'"${mh_col}"'2/g ; s/rw-/'"${mh_col}"'6/g
    s/---/'"${mh_col}"'0/g ; s/--x/'"${ex_col}"'1/g ; s/r-x/'"${ex_col}"'5/g
    s/-wx/'"${ex_col}"'3/g ; s/rwx/'"${ex_col}"'7/g ; s/rwt/'"${st_col}"'7/g
    s/rwT/'"${st_col}"'6/g ; s/rws/'"${tw_col}"'7'"${nocolor}"'/g ; s/rwS/'"${tw_col}"'7'"${nocolor}"'/g
    s/\t/&'"${z_col}"'/' ;
}
