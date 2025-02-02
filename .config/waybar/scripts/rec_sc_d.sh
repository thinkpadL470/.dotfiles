#!/usr/bin/env dash
# -- deamon for recording scripts
recordings=0

UpdateRec () {
    [ "$recordings" -gt 0 ] &&
        [ -s "$(cat ${UPID_DIR}/rec_sc.pid)" ] && echo ""
        [ -s "$(cat ${UPID_DIR}/rec_sc_gif.pid)" ] && echo "󰄄"
    [ "$recordings" -lt 1 ] && {
        dd if=/dev/null of=${UPID_DIR}/rec_sc.pid &&
        dd if=/dev/null of=${UPID_DIR}/rec_sc_gif.pid &&
        dd if=/dev/null of=${UPID_DIR}/wf-recorder.pid
    } 2>&1 > /dev/null && echo
};
begin_record () {
    recordings=$((recordings + 1))
    UpdateRec
};
end_record () {
    recordings=$((recordings - 1))
    UpdateRec
};

exec sleep 2147483647 & spid="$!"
trap begin_record SIGUSR1
trap end_record SIGUSR2
trap "kill $spid" EXIT
while :; do
    wait "$spid"
done
# --
