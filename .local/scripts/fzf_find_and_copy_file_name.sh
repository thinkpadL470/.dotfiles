#!/bin/dash
[ -d /data/data/com.termux ] &&
  basedir="/data/data/com.termux/files/"
[ -d /home ] &&
  basedir="/"
[ -x /bin/sudo ] && [ ! -x /bin/doas ] &&
  auth=sudo
[ ! -x /bin/sudo ] && [ -x /bin/doas ] &&
  auth=doas
[ -x /bin/sudo ] && [ -x /bin/doas ] &&
  printf -- 'doas and sudo installed\nuninstall either doas or sudo\n'
[ -x /bin/wl-copy ] &&
  cbc="wl-copy"
[ -x /data/data/com.termux/files/usr/bin/termux-clipboard-set ] &&
  cbc="termux-clipboard-set"
prunedtargets=$(cat ~/.config/find/pruned | tr '\n' ' ')
${cbc} "$(${auth} find -L ${basedir} -type d \( ${prunedtargets% *} \) -prune -o -type f -print 2>/dev/null | fzf --reverse --header='Copy File Path')"
