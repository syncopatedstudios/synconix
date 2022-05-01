#!/bin/bash

xrandr --output DP1 --off --output DP2 --off --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI2 --off --output VGA1 --off --output VIRTUAL1 --off

if [ "$?" -ne 0 ]; then
  notify-send -u critical "monitor reconfiguration was not successful"
else
  $HOME/.config/i3/scripts/polybar.sh
fi
