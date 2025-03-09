usage () {
    printf '%s\n\t%s\n\t%s\n\t%s\n\t%s\n' \
        "usage: $(basename $0): [-1,-2,--verbose]" \
        "-h         print this help" \
        "-1         use ifconfig.me" \
        "-2         use ifconfig.io" \
        "--verbose  use a verbose output on ipinfo.io." ;
}
