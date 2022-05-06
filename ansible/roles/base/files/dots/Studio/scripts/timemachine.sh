#!/usr/bin/env bash

RECORDINGS="$HOME/Studio/recordings/timemachine"

CAPTURE="Built-in Audio Analog Stereo:capture_FL"

if ! [ -d $RECORDINGS ]; then
  mkdir -pv ~/Studio/recordings/timemachine
fi

if ! pgrep -x "timemachine" > /dev/null; then
  swallow -d timemachine -a -b -25.0 -e -30.0 -T 5 -t 10 -c 2 'Built-in Audio Analog Stereo:capture_FL' 'Built-in Audio Analog Stereo:capture_FL' -f flac -s -p "$RECORDINGS/tm-"
fi
