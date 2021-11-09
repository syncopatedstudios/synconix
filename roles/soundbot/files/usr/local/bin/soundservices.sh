#!/usr/bin/env bash
#
# SPDX-License-Identifier: GPL-3.0-or-later

usage() {
    cat <<- _EOF_
    sound helper script. adapted from the arch livecd sound helper script
    Usage: sound [OPTION]
    OPTIONS
        -s, --stop        stop sound services
        -j, --jack        starts jack dbus and a2jmidid
        -p, --pulse       starts pulseaudio
        -l, --levels      ensures alsa levels are normalized
        -h, --help        Show this usage message

_EOF_
}

bugout () {
    printf "/usr/local/bin/sound: programming error"
    stat_fail
}

echo_card_indices()
{
    if [ -f /proc/asound/cards ] ; then
        sed -n -e's/^[[:space:]]*\([0-7]\)[[:space:]].*/\1/p' /proc/asound/cards
    fi
}

# The following functions try to set many controls.
# No card has all the controls and so some of the attempts are bound to fail.
# Because of this, the functions can't return useful status values.

# $1 <card id>
# $2 <control>
# $3 <level>
unmute_and_set_level(){
    { [ "$3" ] &&[ "$2" ] && [ "$1" ] ; } || bugout
    systemd-cat -t "sound" printf "Setting: %s on card: %s to %s\n" "$2" "$1" "$3"
    systemd-cat -t "sound" amixer -c "$1" set "$2" "$3" unmute
    return 0
}

# $1 <card id>
# $2 <control>
mute_and_zero_level()
{
    { [ "$1" ] && [ "$2" ] ; } || bugout
    systemd-cat -t "sound" printf "Muting control: %s on card: %s\n" "$2" "$1"
    systemd-cat -t "sound" amixer -c "$1" set "$2" "0%" mute
    return 0
}

# $1 <card ID>
# $2 <control>
# $3 "on" | "off"
switch_control()
{
    { [ "$3" ] && [ "$1" ] ; } || bugout
    systemd-cat -t "sound" printf "Switching control: %s on card: %s to %s\n" "$2" "$1" "$3"
    systemd-cat -t "sound" amixer -c "$1" set "$2" "$3"
    return 0
}

# $1 <card ID>
sanify_levels_on_card()
{
    unmute_and_set_level "$1" "Front" "92%"
    unmute_and_set_level "$1" "Master" "92%"
    unmute_and_set_level "$1" "Headphone" "92%"
    unmute_and_set_level "$1" "PCM" "90%"
    # unmute_and_set_level "$1" "PCM,1" "80%"

    # mute_and_zero_level "$1" "Mic"
    mute_and_zero_level "$1" "IEC958"         # Ubuntu #19648
    mute_and_zero_level "$1" "Surround"
    mute_and_zero_level "$1" "Center"
    mute_and_zero_level "$1" "LFE"
    mute_and_zero_level "$1" "Capture"
    mute_and_zero_level "$1" "Capture,1"
    mute_and_zero_level "$1" "Speaker+LO"

    # D1984 -- Thinkpad T61/X61
    switch_control "$1" "Speaker" off
    switch_control "$1" "Headphone" on
    switch_control "$1" "Capture" off
    switch_control "$1" "Capture,1" off

    # HDA-Intel w/ "Digital" capture mixer (See Ubuntu #193823)
    #unmute_and_set_level "$1" "Digital" "80%"
    # mute_and_zero_level "$1" "Digital"
    return 0
}

# $1 <card ID> | "all"
sanify_levels()
{
    local ttsdml_returnstatus=0
    local card
    case "$1" in
      all)
        for card in $(echo_card_indices) ; do
            sanify_levels_on_card "$card" || ttsdml_returnstatus=1
        done
        ;;
      *)
        sanify_levels_on_card "$1" || ttsdml_returnstatus=1
        ;;
    esac
    return $ttsdml_returnstatus
}

# List all cards that *should* be usable for PCM audio.  In my experience,
# the console speaker (handled by the pcsp driver) isn't a suitable playback
# device, so we'll exclude it.
list_non_pcsp_cards()
{
    for card in $(echo_card_indices); do
        local cardfile="/proc/asound/card${card}/id"
        if [ -r "$cardfile" ] && [ -f "$cardfile" ] && \
            [ "$(cat "$cardfile")" != pcsp ]; then
            echo "$card"
        fi
    done
}

# Properly initialize the sound card so that we have audio at boot.
unmute_all_cards()
{
    sanify_levels all
}

is_numeric() {
    local str=$1
    [[ "$str" =~ ^[0-9]+$ ]]
}

set_default_card() {
    local card=$1
    sed -e "s/%card%/$card/g" < /usr/local/share/livecd-sound/asound.conf.in \
        > /etc/asound.conf
}

play_on_card() {
    local card=$1 file=$2
    aplay -q "-Dplughw:$card,0" "$file"
}

freqset() {
  sudo echo 3072 > /sys/class/rtc/rtc0/max_user_freq
}

start_jack() {
  jack_control start
}

stop_jack() {
  if pgrep -x "jackdbus" > /dev/null ; then
    jack_control exit
  else
    systemd-cat -t "sound" printf "jackdbus is not running"
  fi
}

start_pulse() {
  if pgrep -x "pulseaudio" > /dev/null ; then
    systemd-cat -t "sound" printf "pulseaudio is already running"
  else
    pulseaudio --start
  fi
}

stop_pulse() {
  if pgrep -x "pulseaudio" > /dev/null ; then
    pulseaudio -k
  else
    systemd-cat -t "sound" printf "pulseaudio is not running"
  fi
}

start_a2j() {
  if pgrep -x "a2jmidid" > /dev/null ; then
    systemd-cat -t "sound" printf "a2jmidid is already running"
  else
    a2jmidid -e &
  fi
}

stop_a2j() {
  if pgrep -x "a2jmidid" > /dev/null ; then
    pkill -9 a2jmidid
  else
    systemd-cat -t "sound" printf "a2jmidid is not running"
  fi
}

disconnect_pulse_source() {
  if pgrep -x "pulseaudio" > /dev/null ; then
    jack_disconnect "system:capture_1" "PulseAudio JACK Source:front-left" || true
    sleep 0.1
    jack_disconnect "system:capture_2" "PulseAudio JACK Source:front-right" || true
  else
      systemd-cat -t "sound" printf "pulseaudio is not running"
  fi
}

# If there are multiple usable sound cards, prompt the user to choose one,
# using auditory feedback.
# pick_a_card()
# {
#     set -f
#     usable_cards="$(list_non_pcsp_cards)"
#     num_usable_cards="$(wc -w <<< "$usable_cards")"
#
#     if [ "$num_usable_cards" -eq 1 ]; then
#         systemd-cat -t "sound" printf "Only one sound card is detected\n"
#         exit 0
#     fi
#     systemd-cat -t "sound" printf "multiple sound cards detected\n"
#     for card in $usable_cards; do
#         if ! is_numeric "$card"; then
#             continue
#         fi
#         play_on_card "$card" /usr/share/livecd-sounds/pick-a-card.wav&
#     done
#     wait
#     sleep 1
#     for card in $usable_cards; do
#         if ! is_numeric "$card"; then
#             continue
#     fi
#     play_on_card "$card" /usr/share/livecd-sounds/beep.wav
#     if read -r -t 10; then
#         systemd-cat -t "sound" printf "Selecting %s sound card as default\n" "$card"
#         set_default_card "$card"
#         break
#     fi
# done
# }

if [[  $# -eq 0 ]]; then
    echo "error: No argument passed."
    exit 1
fi
while [[ "${1}" != "" ]]; do
    case ${1} in
        -h|--help)
            usage
            exit
            ;;
        -a|--a2jmidid)
            start_a2j
            sleep 0.5
            ;;
        -j|--jack)
            start_jack
            sleep 0.5
            ;;
        -s|--stop)
            stop_jack
            sleep 0.5
            stop_a2j
            sleep 0.5
            stop_pulse
            ;;
        -l|--levels)
            systemd-cat -t "sound" printf "Unmuting all cards"
            unmute_all_cards
            ;;
        -p|--pulse)
            start_pulse
            disconnect_pulse_source
            ;;
        *)
            echo "error: Unsupported argument"
            usage
            exit 1
            ;;
    esac
    shift
done
