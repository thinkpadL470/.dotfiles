#!/bin/dash
[ -d /data/data/com.termux ] &&
    basedir="/data/data/com.termux/files/"
[ -d /home ] &&
    pwd_trunkated=$(printf "${PWD}" | cut -d '/' -f '1,2,3') &&
        basedir="${pwd_trunkated}"
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
