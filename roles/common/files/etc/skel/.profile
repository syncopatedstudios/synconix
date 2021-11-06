#if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
  # Most pure GTK3 apps use wayland by default, but some,
  # like Firefox, need the backend to be explicitely selected.
#  export LD_PRELOAD=/usr/lib/libgtk3-nocsd.so.0
#  export LIBVA_DRIVER_NAME=v4l2_request
#  export LIBVA_V4L2_REQUEST_VIDEO_PATH=/dev/video1
#  export MOZ_ENABLE_WAYLAND=1
#  export MOZ_DBUS_REMOTE=1
#  export GTK_CSD=0
#  export QT_QPA_PLATFORM="wayland"
#  export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
#  export _JAVA_AWT_WM_NONREPARENTING=1
#fi

export QT_QPA_PLATFORMTHEME=qt5ct

export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
