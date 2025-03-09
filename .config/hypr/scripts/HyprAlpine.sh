#!/usr/bin/sh
# -- session
export XCURSOR_SIZE=24
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=hyprland
export XDG_SESSION_DESKTOP=hyprland
export LIBSEAT_BACKEND=seatd
# --

# -- wayland
export WLR_NO_HARDWARE_CURSORS=1
export MOZ_ENABLE_WAYLAND=1
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
# --

# -- launch session
export XDG_VTNR=$(basename "$(tty)" | sed 's/tty//')
[ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ] && {
    exec dbus-run-session Hyprland ;
}
# --
