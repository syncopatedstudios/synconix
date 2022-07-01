#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
#set -vx

a2j_control --status | awk '{print $2}'| grep enabled

if [ "$?" == 0 ];
then
  a2j_control --exit
fi
