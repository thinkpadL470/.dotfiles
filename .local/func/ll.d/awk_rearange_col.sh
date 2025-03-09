awk_rearange_col () {
    awk -F '\t' '{ OFS="\t"; print $1,$3,$4,$2 }' ;
}
