#!/bin/dash
[ -d /home ] && {
    basedir=$(printf "${PWD}" | cut -d '/' -f '1-3') ;
    basedirroot=$(printf "${PWD}" | cut -d '/' -f '1-2') ;
};
[ -d /data/data/com.termux/files/home ] && {
    basedir=$(printf "${PWD}" | cut -d '/' -f '1-6') ;
    basedirroot=$(printf "${PWD}" | cut -d '/' -f '1-5') ;
};
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
