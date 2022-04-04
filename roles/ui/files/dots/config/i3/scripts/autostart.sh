#!/usr/bin/env bash


# i3-msg exec /usr/bin/kitty;sleep 1

i3-msg workspace 9, layout splitv
i3-msg workspace 10, layout splitv
i3-msg workspace 1

i3exec="exec --no-startup-id"

if ! pgrep -x s | grep -e "\-v \-s" > /dev/null
then
  i3-msg "$i3exec s -v -s";sleep 2
fi

if ! pgrep -x "chrome" > /dev/null
then
  i3-msg "exec --no-startup-id  /usr/bin/google-chrome-stable %U";sleep 2
fi

if ! pgrep -x "zim" > /dev/null
then
  i3-msg "exec --no-startup-id zim";sleep 1
fi

if ! pgrep -x "atom" > /dev/null
then
  i3-msg "exec --no-startup-id env ATOM_DISABLE_SHELLING_OUT_FOR_ENVIRONMENT=false /usr/bin/atom";sleep 1
fi

if ! pgrep -x "patchage" > /dev/null
then
  i3-msg "exec --no-startup-id /usr/local/bin/patchage";sleep 1
fi

if ! pgrep -x "kitty" > /dev/null
then
  i3-msg "exec --no-startup-id kitty -1 --name 'kitty_init'";sleep 1
fi

xdotool search --onlyvisible --name "Patchage" key ctrl+g

i3-msg [class="^kitty_init$"], move container to workspace 9
i3-msg [class="^kitty_init$"], resize shrink height 400px

i3-msg [class="^Zim$"], move container to workspace 10

i3-msg [class="^Google-chrome$"], move container to workspace 10
i3-msg [class="^Google-chrome$"], resize shrink height 100px
