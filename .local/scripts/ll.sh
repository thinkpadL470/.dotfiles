#!/bin/dash
ll () {
    ls --color=always --time-style="+%y-%b-%d-%H-%M" -hAog |
    sed -e 's/^l/'"${LN_C}"'l'"${NC}"'/
            s/^d/'"${DI_C}"'d'"${NC}"'/
            s/^-/'"${FI_C}"'-'"${NC}"'/
            s/r--/'"${FI_C}"'4'"${NC}"'/g
            s/-w-/'"${FI_C}"'2'"${NC}"'/g
            s/rw-/'"${FI_C}"'6'"${NC}"'/g
            s/---/'"${FI_C}"'0'"${NC}"'/g
            s/--x/'"${EX_C}"'1'"${NC}"'/g
            s/r-x/'"${EX_C}"'5'"${NC}"'/g
            s/-wx/'"${EX_C}"'3'"${NC}"'/g
            s/rwx/'"${EX_C}"'7'"${NC}"'/g' |
    tr -s " " "\t" | cut --complement -f '2' |
    sed -e 's/\t/\ /4g ; s/\t/&'"${ARC_C}"'/ ; s/\t/'"${NC}"'&/2' |
    ~/.local/scripts/rearrange.sh 1 3 4 2 |
    sed -e '1d ; s/\ ..-/'"${MH_C}"'&/ ; s/-..\ /&'"${NC}"'/ ; /\(^'"${esc}"'\['"${LS_DI}"'md\|^'"${esc}"'\['"${LS_LN}"'ml\)/s/'"${esc}"'\['"${LS_ARC}"'.*$//g'
} ;
ll "${@}"
