#!/usr/bin/env bash

query=$(zenity --entry)

if [ -z "$query" ];then
  echo "NULL";
else
  if ! pgrep -x "chrome" > /dev/null
  then
    i3-msg "exec --no-startup-id  /usr/bin/google-chrome-stable %U";sleep 2
  fi
  /usr/bin/s $query -t linux
fi
