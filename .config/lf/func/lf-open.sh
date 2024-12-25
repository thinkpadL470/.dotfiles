#/bin/dash
. ~/.bashrc
. ~/.config/lf/func/lf_open_filetype_vars.sh
test -L $f && f=$(readlink -f $f)
case $(file --mime-type $f -b) in
image/vnd.djvu | application/pdf | application/octet-stream)
  setsid -f zathura $f
  ;;
text/* | application/json)
  $EDITOR $fx
  ;;
image/*)
  imv $f 2>/dev/null
  ;;
audio/*)
  mpv --audio-display=no $f
  ;;
video/*)
  setsid -f mpv --mute=yes $fx -quiet >/dev/null 2>&1
  ;;
*)
  for f in $fx; do
    setsid -f $OPENER $f >/dev/null 2>&1
  done
  ;;
esac
