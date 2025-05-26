#!/usr/bin/sh
# -- session
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_DESKTOP=Hyprland
# --

# -- theming
export XCURSOR_SIZE=24

    # -- QT
    export QT_AUTO_SCREEN_SCALE_FACTOR=1
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export QT_QPA_PLATFORM=wayland;xcb
    export QT_QPA_PLATFORMTHEME=qt5ct:qt6ct
    # --

    # -- GDK
    export GDK_BACKEND=wayland,x11
    # --
# --

# -- wayland
export WLR_NO_HARDWARE_CURSORS=1
export MOZ_ENABLE_WAYLAND=1
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export WLR_RENDER_ALLOW_SOFTWARE=1
export MOZ_ENABLE_WAYLAND=1
export SDL_VIDEODRIVER=wayland
# --

# -- NVIDIA
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export LIBVA_DRIVER_NAME=nvidia
export __GL_GSYNC_ALLOWED=0
export __GL_VRR_ALLOWED=0
export AQ_NO_ATOMIC=0
# --

exec Hyprland
