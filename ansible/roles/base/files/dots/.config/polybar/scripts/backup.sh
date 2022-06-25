#!/usr/bin/env bash


if ! pgrep -a "sync" > /dev/null; then
  notify-send -u normal "starting backup"
  
  osync.sh /etc/osync/sync_home.conf --silent --summary --verbose --stats
  
  if [ "$?" -ne 0 ]; then
    notify-send -u normal "backup failed"
    rm -rf ~/osync.thinkbot_home.log
  else
    notify-send -u normal "backup did not fail"
  fi



else
  notify-send -u normal "backup already happening"
fi

