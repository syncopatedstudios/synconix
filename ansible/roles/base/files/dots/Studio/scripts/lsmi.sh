#!/usr/bin/env bash

# script here some actions to run once the session is loaded.
keyboard_id=$(xinput list | grep 'Dell KB216 Wired Keyboard' | awk -F ' ' '{ print $6 }' | grep id | awk -F '=' '{ print $2 }')

keyboard_event=$(xinput --list-props $keyboard_id | grep event | awk -F " " '{ print $4 }')

if  [ -x "$(xinput list | grep 'Dell KB216 Wired Keyboard')" > /dev/null ]
then
  echo "this keyboard is not connected"
else
  if ! pgrep -x "lsmi-keyhack" > /dev/null
  then
    i3-msg "exec --no-startup-id /usr/local/bin/lsmi-keyhack -k /home/b08x/Studio/configs/lsmi/keydb -d $keyboard_event &"
  fi
fi
