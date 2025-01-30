#!/bin/bash
# -- deamon for recording scripts
recordings=0

UpdateRec () {
    [ "$recordings" -gt 0 ] &&
        [ -n "$(pgrep rec_sc.sh)" ] && echo ""
        [ -n "$(pgrep rec_sc_gif.sh)" ] && echo "󰄄"
    [ "$recordings" -lt 1 ] && echo
};
begin_record () {
    recordings=$((recordings + 1))
    UpdateRec
};
end_record () {
    recordings=$((recordings - 1))
    UpdateRec
};

exec sleep infinity &
pid="$!"
trap begin_record SIGUSR1
trap end_record SIGUSR2
trap "kill $pid" EXIT
while :; do
    wait "$pid"
done
# --
