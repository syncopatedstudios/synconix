#!/usr/bin/env bash


if ! pgrep -a "sync" > /dev/null; then
  notify-send -u normal "starting backup"
  osync.sh /etc/osync/sync_crambot_to_bender.conf --silent --summary --verbose --stats
else
  notify-send -u normal "backup already happening"
fi

if [ "$?" -ne 0 ]; then
  notify-send -u normal "backup failed"
else
  notify-send -u normal "backup did not fail"
fi
