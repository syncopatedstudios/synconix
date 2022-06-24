#!/usr/bin/env bash

RECORDINGS="$HOME/Studio/recordings/timemachine"

CAPTURE="Built-in Audio Analog Stereo:capture_FL"

set_mic_levels()
{
  systemd-cat -t "fmit" amixer set 'Capture' 9%
  systemd-cat -t "fmit" amixer -D hw:0 set 'Capture' 78%
  systemd-cat -t "fmit" amixer -D hw:0 set 'Internal Mic Boost' 67%
  return 0
}


if ! [ -d $RECORDINGS ]; then
  mkdir -pv ~/Studio/recordings/timemachine
fi

if ! pgrep -x "timemachine" > /dev/null; then
  set_mic_levels
  kitty -e timemachine -i -t 10 -c 2 'Built-in Audio Analog Stereo:capture_FL' 'Built-in Audio Analog Stereo:capture_FR' -f flac -s -p "$RECORDINGS/tm-"
fi
