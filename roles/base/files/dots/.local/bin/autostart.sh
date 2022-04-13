#!/usr/bin/env bash


# i3-msg exec /usr/bin/kitty;sleep 1

i3-msg workspace 9, layout splitv
i3-msg workspace 10, layout splitv
i3-msg workspace 1

i3exec="exec --no-startup-id"

if ! pgrep -x "s" > /dev/null
then
  i3-msg "exec --no-startup-id 's -s -v'";sleep 1
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
  i3-msg "exec --no-startup-id env ATOM_DISABLE_SHELLING_OUT_FOR_ENVIRONMENT=false /usr/bin/atom";sleep 5s
fi

if ! pgrep -x "patchage" > /dev/null
then
  i3-msg "exec --no-startup-id patchage";sleep 1
fi

if ! pgrep -x "kitty" > /dev/null
then
  i3-msg "exec --no-startup-id kitty -o allow_remote_control=yes --listen-on unix:/tmp/mykitty --class 'kitty_init' --session $HOME/.config/kitty/start.conf";sleep 1
fi


i3-msg [class='kitty_init'], move container to output HDMI1
# i3-msg [class="^kitty_init$"], resize shrink height 400px

i3-msg [class="^Google-chrome$"], move container to output HDMI1
# i3-msg [class="^Google-chrome$"], resize shrink height 100px

i3-msg [class="^Zim$"], move container to workspace 10

i3-msg [class="^Patchage$"], move container to workspace 10

i3-msg workspace 10
xdotool search --onlyvisible --name "Patchage" key ctrl+g

i3-msg workspace 1
