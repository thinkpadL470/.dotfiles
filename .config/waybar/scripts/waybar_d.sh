#!/usr/bin/env dash
printf '%s' "$$" > ${UPID_DIR}/hyprbar_d.pid
trap "dd if=/dev/null of=${UPID_DIR}/hyprbar.pid && dd if=/dev/null of=${UPID_DIR}/hyprbar_d.pid ; exit" INT TERM KILL
trap "kill 0" EXIT
[ -n "${HYPR_BAR}" ] && { ${HYPR_BAR} & hyprbar_PID=$! ; }
[ -z "${HYPR_BAR}" ] && { waybar & hyprbar_PID=$! ; }
printf '%s' "${hyprbar_PID}" > ${UPID_DIR}/hyprbar.pid
wait "${hyprbar_PID}"
