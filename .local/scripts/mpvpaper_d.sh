#!/bin/env dash
printf '%s' "$$" > ${UPID_DIR}/mpvpaper_d.sh
trap "kill -- -$$ && dd if=/dev/null of=${UPID_DIR}/mpvpaper.pid && dd if=/dev/null of=${UPID_DIR}/mpvpaper_d.pid ; exit" INT TERM KILL
trap "kill 0" EXIT
mpvpaper -o \
    "no-config load-scripts=no aid=no loop-file=inf vo=libmpv panscan=1" \
    '*' \
    "${1}" & mpvpaper_PID="$!"
printf '%s' "${mpvpaper_PID}" > ${UPID_DIR}/mpvpaper.pid
wait "${mpvpaper_PID}"
