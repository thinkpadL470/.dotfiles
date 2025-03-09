case "$1" in
    nanosecs) date +%y.%b.%d.%H.%M.%S.%6N
        ;;
    secs) date +%y.%b.%d.%H.%M.%S
        ;;
    *) date +%y.%b.%d.%H
        ;;
esac ;
