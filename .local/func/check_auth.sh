#!/usr/bin/env dash
[ -x /bin/sudo ] && [ ! -x /bin/doas ] &&
    auth=sudo
[ ! -x /bin/sudo ] && [ -x /bin/doas ] &&
    auth=doas
[ -x /bin/sudo ] && [ -x /bin/doas ] &&
    printf '%s\n%s\n' "doas and sudo installed " "uninstall either doas or sudo"
