#!/usr/bin/env bash

CAPTURE="Built-in Audio Analog Stereo:capture_FL"

set_mic_levels()
{
  systemd-cat -t "fmit" amixer set 'Capture' 9%
  systemd-cat -t "fmit" amixer -D hw:0 set 'Capture' 78%
  systemd-cat -t "fmit" amixer -D hw:0 set 'Internal Mic Boost' 67%
  return 0
}


if ! pgrep -x "fmit" > /dev/null; then
  set_mic_levels
  swallow -d fmit
fi
