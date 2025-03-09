#!/usr/bin/env dash
. ~/.config/lf/func/lf_open_filetype_vars.sh
# -- define programs to use to open file in diffrent cases
test -L $f && f=$(readlink -f $f)
case $(file --mime-type $f -b) in
image/vnd.djvu | application/pdf | application/octet-stream)
    sh -c 'zathura $0' $f & exit
    ;;
text/* | application/json)
    $EDITOR $fx
    ;;
image/*)
    setpgid imv $fx > /dev/null 2>&1 &
    ;;
audio/*)
    mpv --audio-display=no $f
    ;;
video/*)
    setpgid mpv --mute=yes --really-quiet $fx > /dev/null 2>&1 &
    ;;
*)
    for f in $fx; do
        setpgid -f $OPENER $f >/dev/null 2>&1
    done
    ;;
esac
# --
