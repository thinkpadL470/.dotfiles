#!/usr/bin/env dash
[ -x /bin/wl-copy ] &&
    cbc="wl-copy"
[ -x /data/data/com.termux/files/usr/bin/termux-clipboard-set ] &&
    cbc="termux-clipboard-set"
