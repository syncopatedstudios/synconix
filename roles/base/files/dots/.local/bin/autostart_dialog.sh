#/usr/bin/env sh

dialog --clear \
  --title 'New as of 4.12.22' \
  --msgbox \
"# Use kitty links with rga to search and edit\n\n
---------------------\n \

> hg 'search term'\n \

---------------------\n\n
# Extract portions of a video file with mpv\n\n

mpv excerpt:\n \
'b' to begin\n \
'n' to mark the end\n \
'x' to write the file\n \
'L' to toggle looping" 18 80
