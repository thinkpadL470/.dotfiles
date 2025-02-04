#!/usr/bin/env dash
printf '%s' "$$" > ${UPID_DIR}/hyprpaper_d.pid
trap "dd if=/dev/null of=${UPID_DIR}/hyprpaper.pid && dd if=/dev/null of=${UPID_DIR}/hyprpaper_d.pid ; exit" INT TERM QUIT
trap "kill 0" EXIT
hyprpaper & hyprp_PID=$!
cat /run/user/1000/hyprpaper.lock > ${UPID_DIR}/hyprpaper.pid
wait "${hyprp_PID}"
