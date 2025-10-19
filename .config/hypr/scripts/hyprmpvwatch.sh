#!/usr/bin/env dash
url="$(wl-paste -n 2>/dev/null)"
luaScript="${HOME}/.config/hypr/scripts/hyprmpvwatch.lua"

case "${url}" in
    https://* ) ;;
    * )
        notify-send -u critical -a mpv "Not a link" "Clipboard is not a https URL"
        exit 1
        ;;
esac

mpv --script="${luaScript}" --volume=50 -- "$url" >/dev/null 2>&1 &
