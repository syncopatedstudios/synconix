# grub

awk '/menuentry/ && /class/ {count++; print count-1"****"$0 }' /boot/grub/grub.cfg                                                                                                      root@calculon 18:06:58
0****menuentry 'Arch Linux' --class arch --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-simple-05be3904-0b6c-4717-a8d1-c3a091926cd9' {
1****	menuentry 'Arch Linux, with Linux linux-lts' --class arch --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-linux-lts-advanced-05be3904-0b6c-4717-a8d1-c3a091926cd9' {
2****	menuentry 'Arch Linux, with Linux linux-lts (fallback initramfs)' --class arch --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-linux-lts-fallback-05be3904-0b6c-4717-a8d1-c3a091926cd9' {


grub-set-default 'Advanced options for Arch Linux>Arch Linux, with Linux linux-lts'

The above works because the man 8 grub-set-default page says this about MENU_ENTRY option:

MENU_ENTRY is a number, a menu item title or a menu item identifier.

# pipewire
soundcard:
  alsa_out: alsa_output.pci-0000_00_1b.0.playback.0.0
  resample_quality: 10
  channels: 6
  format: "S32LE"
  rate: 48000
  allowed-rates: "32000,44100,48000,96000"
  position: "FL,FR,RL,RR,FC,LFE"


# xresources
--------


URxvt.font:                       9x15,xft:TerminessTTFNerdFontMono

! alternative font settings with 'terminus':
! URxvt.font:      -xos4-terminus-medium-r-normal--16-160-72-72-c-80-iso10646-1
! URxvt.bold.font: -xos4-terminus-bold-r-normal--16-160-72-72-c-80-iso10646-1
!! terminus names see end of file!

URxvt.depth:                      32
! URxvt.background:                 [100]#222D31
URxvt.background:                 [100]#0f1011
URxvt*scrollBar:                  True
URxvt*mouseWheelScrollPage:       false
URxvt*cursorBlink:                true
URxvt*background:                 black
URxvt*foreground:                 grey
URxvt*saveLines:                  5000

! for 'fake' transparency (without Compton) uncomment the following three lines
! URxvt*inheritPixmap:            true
! URxvt*transparent:              true
! URxvt*shading:                  138

! Normal copy-paste keybindings without perls
URxvt.iso14755:                   false
URxvt.keysym.Shift-Control-V:     eval:paste_clipboard
URxvt.keysym.Shift-Control-C:     eval:selection_to_clipboard
!Xterm escape codes, word by word movement
URxvt.keysym.Control-Left:        \033[1;5D
URxvt.keysym.Shift-Control-Left:  \033[1;6D
URxvt.keysym.Control-Right:       \033[1;5C
URxvt.keysym.Shift-Control-Right: \033[1;6C
URxvt.keysym.Control-Up:          \033[1;5A
URxvt.keysym.Shift-Control-Up:    \033[1;6A
URxvt.keysym.Control-Down:        \033[1;5B
URxvt.keysym.Shift-Control-Down:  \033[1;6B
! Rxvt.perl-ext-common:             ...,clipboard
! URxvt.keysym.M-C-c:               perl:clipboard:copy
! URxvt.keysym.M-v:                 perl:clipboard:paste
! URxvt.keysym.M-C-v:               perl:clipboard:paste_escaped
! URxvt*termName:                   string
! URxvt*geometry:                   geometry
! URxvt*chdir:                      string
! URxvt*loginShell:                 boolean
! URxvt*multiClickTime:             number
! URxvt*jumpScroll:                 boolean
! URxvt*skipScroll:                 boolean
! URxvt*pastableTabs:               boolean
! URxvt*scrollstyle:                plain
! URxvt*scrollBar_right:            boolean
! URxvt*scrollBar_floating:         true
! URxvt*scrollBar_align:            mode
! URxvt*thickness:                  number
! URxvt*scrollTtyOutput:            boolean
! URxvt*scrollTtyKeypress:          boolean
! URxvt*scrollWithBuffer:           boolean
! URxvt*tintColor:                  !7DA55
! URxvt*blurRadius:                 HxV
! URxvt*fading:                     number
! URxvt*fadeColor:                  color
! URxvt*utmpInhibit:                boolean
! URxvt*urgentOnBell:               boolean
! URxvt*visualBell:                 boolean
! URxvt*mapAlert:                   boolean
! URxvt*meta8:                      boolean
! URxvt*tripleclickwords:           boolean
! URxvt*insecure:                   boolean
! URxvt*cursorUnderline:            boolean
! URxvt*pointerBlank:               boolean
! URxvt*color0:                     color
! URxvt*color1:                     color
! URxvt*color2:                     color
! URxvt*color3:                     color
! URxvt*color4:                     color
! URxvt*color5:                     color
! URxvt*color6:                     color
! URxvt*color7:                     color
! URxvt*color8:                     color
! URxvt*color9:                     color
! URxvt*color10:                    color
! URxvt*color11:                    color
! URxvt*color12:                    color
! URxvt*color13:                    color
! URxvt*color14:                    color
! URxvt*color15:                    color
! URxvt*colorBD:                    color
! URxvt*colorIT:                    color
! URxvt*colorUL:                    color
! URxvt*colorRV:                    color
! URxvt*underlineColor:             color
! URxvt*scrollColor:                color
! URxvt*troughColor:                color
! URxvt*highlightColor:             color
! URxvt*highlightTextColor:         color
! URxvt*cursorColor:                color
! URxvt*cursorColor2:               color
! URxvt*pointerColor:               color
! URxvt*pointerColor2:              color
! URxvt*borderColor:                color
! URxvt*iconFile:                   file
! URxvt*font:                       fontname
! URxvt*boldFont:                   fontname
! URxvt*italicFont:                 fontname
! URxvt*boldItalicFont:             fontname
! URxvt*intensityStyles:            boolean
! URxvt*inputMethod:                name
! URxvt*preeditType:                style
! URxvt*imLocale:                   string
! URxvt*imFont:                     fontname
! URxvt*title:                      string
! URxvt*iconName:                   string
! URxvt*buffered:                   boolean
! URxvt*depth:                      number
! URxvt*visual:                     number
! URxvt*transient-for:              windowid
! URxvt*override-redirect:          boolean
! URxvt*hold:                       boolean
! URxvt*externalBorder:             number
! URxvt*internalBorder:             number
! URxvt*borderLess:                 true
! URxvt*lineSpace:                  number
! URxvt*letterSpace:                number
! URxvt*skipBuiltinGlyphs:          boolean
! URxvt*pointerBlankDelay:          number
! URxvt*backspacekey:               string
! URxvt*deletekey:                  string
! URxvt*print-pipe:                 string
! URxvt*modifier:                   modifier
! URxvt*cutchars:                   string
! URxvt*answerbackString:           string
! URxvt*secondaryScreen:            boolean
! URxvt*secondaryScroll:            boolean
! URxvt*perl-lib:                   string
! URxvt*perl-eval:                  perl-eval
! URxvt*perl-ext-common:            string
! URxvt*perl-ext:                   string
! URxvt*iso14755:                   boolean
! URxvt*iso14755_52:                boolean
! URxvt*xrm:                        string
! URxvt*keysym.sym:                 keysym
! URxvt*background.border:          boolean
! URxvt*background.expr:            string
! URxvt*background.interval:        seconds
! URxvt*bell-command:               string
! URxvt*kuake.hotkey:               string
! URxvt*matcher.button:             string
! URxvt*matcher.launcher:           string
! URxvt*matcher.launcher.*:         string
! URxvt*matcher.pattern.*:          string
! URxvt*matcher.rend.*:             string
! URxvt*remote-clipboard.fetch:     string
! URxvt*remote-clipboard.store:     string
! URxvt*searchable-scrollback:      string
! URxvt*selection-autotransform.*:  string
! URxvt*selection-pastebin.cmd:     string
! URxvt*selection-pastebin.url:     string
! URxvt*selection.pattern-0:        string
! URxvt*tab-bg:                     colour
! URxvt*tab-fg:                     colour
! URxvt*tabbar-bg:                  colour
! URxvt*tabbar-fg:                  colour
! URxvt*url-launcher:               string

! The Terminus font uses the following X-names:
! -xos4-terminus-medium-r-normal--12-120-72-72-c-60-iso10646-1
! -xos4-terminus-medium-r-normal--14-140-72-72-c-80-iso10646-1
! -xos4-terminus-medium-r-normal--16-160-72-72-c-80-iso10646-1
! -xos4-terminus-medium-r-normal--20-200-72-72-c-100-iso10646-1
! -xos4-terminus-medium-r-normal--22-220-72-72-c-110-iso10646-1
! -xos4-terminus-medium-r-normal--24-240-72-72-c-120-iso10646-1
! -xos4-terminus-medium-r-normal--28-280-72-72-c-140-iso10646-1
! -xos4-terminus-medium-r-normal--32-320-72-72-c-160-iso10646-1
! -xos4-terminus-bold-r-normal--12-120-72-72-c-60-iso10646-1
! -xos4-terminus-bold-r-normal--14-140-72-72-c-80-iso10646-1
! -xos4-terminus-bold-r-normal--16-160-72-72-c-80-iso10646-1
! -xos4-terminus-bold-r-normal--20-200-72-72-c-100-iso10646-1
! -xos4-terminus-bold-r-normal--24-240-72-72-c-120-iso10646-1
! -xos4-terminus-bold-r-normal--28-280-72-72-c-140-iso10646-1
! -xos4-terminus-bold-r-normal--32-320-72-72-c-160-iso10646-1


*background:        #222D31
*background:        #b68554
*background:        #0d0c0c
*foreground:        #d8d8d8
*foreground:        #0d0c0c
*foreground:        #2d5e9d




URxvt.depth:                32
URxvt.geometry:             90x30
URxvt.loginShell:           true
URxvt.internalBorder:       3
URxvt.lineSpace:            0

! transparency - true or false (default)
URxvt*transparent: true

! tint with any color; i.e., blue, red, tomato4, olivedrab2, etc.
!   some nice listings are at:
!     http://www.nisrv.com/drupal/?q=node/11
!     http://www.htmlgoodies.com/tutorials/colors/article.php/3478921
!URxvt*tintColor: S_base03

!shading - 0 to 99 darkens, 101 to 200 lightens.
!Dont use with tintColor; just use a darker or lighter color instead.
URxvt*shading: 15

URxvt*saveLines: 12000

URxvt*foreground: #657b83
URxvt*background: #002b36

! Monaco Linux font
URxvt*font: xft:Hack Nerd Font:pixelsize=15
URxvt*boldFont: xft:Hack Nerd Font:bold:pixelsize=15
URxvt*letterSpace: -1

! scrollbar - true (default) or false
URxvt*scrollBar: true

! scrollbar position - left=false (default) or right=true
URxvt*scrollBar_right: false

! scrollbar style - rxvt (default), plain, next, or xterm
URxvt*scrollstyle: plain
