#!/bin/bash
recordings=0

UpdateRec () {
  test "$recordings" -gt 0 &&
    test -n "$(pgrep -x rec_sc.sh)" && echo ""
    test -n "$(pgrep -x rec_sc_gif.sh)" && echo "󰄄"
  test "$recordings" -lt 1 && echo
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
