#!/bin/bash
# A quick documentation file-finder based on rofi and zeal
# Requires: rofi, zeal, i3-sensible-terminal nerdfonts
files=~/.cache/rofi/rofi-zeal/rofi-zeal_term_list

BROWSER="google-chrome-stable"

append_new_term() {
	# Delete term. Append on the first line.
	sed -i "/$input/d" $files
	sed -i "1i $input" "$files"
	# Max cache limited to 20 entries: https://github.com/Zeioth/rofi-zeal/issues/3
	sed -i 20d "$files"
}

if [ -e $files ]; then
	# If file list exist, use it
	input=$(cat $files | rofi -dmenu -p "manual")
	else
	# There is no file list, create it and show menu only after that
	input=$(cat $files | rofi -dmenu -p "manual")
  #	The file if empty, initialize it, so we can insert on the top later
  if [ ! -s "$_file" ]
  then
    echo " " > "$files"
  fi
fi

case "$(echo $input | cut -d " " -f 1)" in

man)
	# Search on man
	append_new_term
  mantoread=$(echo "$input" | cut -c 4- | xargs)
  export $1 && kitty -e "man $mantoread"
  ;;
dd)
	# Search dev docs
	append_new_term
  exec devdocs-desktop "$(echo $input | sed 's/^....//g')" &> /dev/null &
  ;;
*)
  # Open zeal only if there's text input
	# Search on DevDocs
	append_new_term
  mantoread=$(echo "$input" | cut -c 1- | xargs)
	exec $BROWSER "https://www.google.com/search?q=$mantoread" &> /dev/null &
	exec $BROWSER "https://duckduckgo.com/?q=$mantoread" &> /dev/null &
  exec $BROWSER "https://github.com/search?utf8=✓&q=$mantoread" &> /dev/null &
	exec $BROWSER "https://gist.github.com/search?q=$mantoread" &> /dev/null &
	exec $BROWSER "https://stackoverflow.com/search?q=$mantoread" &> /dev/null &
  ;;
esac
