#!/bin/sh

case $1 in
     start)
           # "open up" the PCI bus by allowing fairly long bursts for all devices, increasing performance
           setpci -v -s "*:*.*" latency_timer=b0

           # maximise latency for RME Hammerfall, thus allowing
           # more data per PCI transfer and minimizing xruns
           #setpci -v -s 01:04.0 latency_timer=ff
           # ditto for the onboard AC97 audio interface
           setpci -v -s 00:1f.3 latency_timer=ff
esac

exit 0
