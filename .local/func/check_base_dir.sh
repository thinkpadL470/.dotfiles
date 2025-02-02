#!/usr/bin/env dash
[ -d /home ] && {
    basedir=$(printf "${PWD}" | cut -d '/' -f '1-3') ;
    basedirroot="/" ;
};
[ -d /data/data/com.termux/files/home ] && {
    basedir=$(printf "${PWD}" | cut -d '/' -f '1-6') ;
    basedirroot=$(printf "${PWD}" | cut -d '/' -f '1-5') ;
};
