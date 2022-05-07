#!/usr/bin/env bash

CAPTURE="Built-in Audio Analog Stereo:capture_FL"

amixer set 'Capture' 9%
amixer -D hw:0 set 'Capture' 78%
amixer -D hw:0 set 'Internal Mic Boost' 67%

if ! pgrep -x "fmit" > /dev/null; then
  swallow -d fmit
fi
