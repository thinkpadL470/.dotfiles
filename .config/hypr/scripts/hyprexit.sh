#!/bin/bash
HYPRCMDS=$(hyprctl -j clients | jq -j '.[] | "dispatch closewindow address:\(.address); "');
hyprctl --batch "$HYPRCMDS";

sleep 1.5

[ -x "/bin/systemctl" ] && setsid -f doas systemctl restart lemurs.service
