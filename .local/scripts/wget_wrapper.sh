#!/usr/bin/env dash
case "$1" in
  -p) wget -nv --progress=bar --show-progress -U 'Mozilla/5.0 (Windows NT 10.0; rv:127.0) Gecko/20100101 Firefox/127.0' "$2"
  ;;
  -pa) wget -nv -N --progress=bar --show-progress -U 'Mozilla/5.0 (Windows NT 10.0; rv:127.0) Gecko/20100101 Firefox/127.0' "$2"
  ;;
  -pr) wget -c -N --progress=bar --wait=5s --random-wait --show-progress -U 'Mozilla/5.0 (Windows NT 10.0; rv:127.0) Gecko/20100101 Firefox/127.0' "$2"
  ;;
  *) printf 'invalid argument\nvalid arguments are\n'
    printf -- '-p\tprogressbar and no verbose\n'
    printf -- '-pa\tprogressbar, no verbose and timestamping\n'
    printf -- '-pr\tprogressbar, continue and verbose\n'
  ;;
esac
