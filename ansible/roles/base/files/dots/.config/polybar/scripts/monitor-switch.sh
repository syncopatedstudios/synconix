#!/usr/bin/env bash

SDIR="$HOME/.config/polybar/scripts"

LAYOUTS="$HOME/.screenlayout"

# Launch Rofi
MENU="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p '' \
-theme $SDIR/rofi/styles.rasi \
<<< " Single| Dual|")"
      case "$MENU" in
				*Single) "$LAYOUTS"/single.sh ;;
				*Dual) "$LAYOUTS"/dual.sh ;;
      esac
