generate_random_string () {
    local min="6" ;
    local max="12" ;
    local char_count=$(($(od -An -N4 -tu /dev/urandom)${min+%(${max+$max- }$min+1)${max++$min}})) ;
    tr -cd "A-Za-z1-9" < /dev/urandom | head -c ${char_count} ;
    return 0 ;
}
