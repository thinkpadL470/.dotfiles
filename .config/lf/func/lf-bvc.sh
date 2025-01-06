cd ~ && rm .bv.*
lwp=~/.bv.
cp $f ${lwp}${f##*.}
[ -z "$(pgrep mpvpaper)" -a -z "$(pgrep hyprpaper)" ] &&
mpvpaper -o no-config load-scripts=no aid=no loop-file=inf vo=libmpv panscan=1 '*' "${lwp}${f##*.}" ||
pkill 'mpvpaper|hyprpaper' &&
mpvpaper -o no-config load-scripts=no aid=no loop-file=inf vo=libmpv panscan=1 '*' "${lwp}${f##*.}"
