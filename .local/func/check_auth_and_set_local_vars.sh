#!/bin/dash
[ -d /home ] && {
    basedir=$(printf "${PWD}" | cut -d '/' -f '1-3') ;
    basedirroot="/" ;
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
    printf '%s\n%s\n' "doas and sudo installed " "uninstall either doas or sudo"
[ -x /bin/wl-copy ] &&
    cbc="wl-copy"
[ -x /data/data/com.termux/files/usr/bin/termux-clipboard-set ] &&
    cbc="termux-clipboard-set"
