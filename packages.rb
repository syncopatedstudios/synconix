#!/usr/bin/env ruby

require 'tty-file'

packages = [ "a2jmidid",
"actdiag",
"adobe-source-han-sans-cn-fonts",
"adobe-source-han-sans-jp-fonts",
"adobe-source-han-sans-kr-fonts",
"alsa-lib",
"alsa-plugins",
"alsa-tools",
"alsa-utils",
"ams",
"ams-lv2",
"arandr",
"arc-gtk-theme",
"aria2",
"aribb24",
"aspell-en",
"atom",
"atool",
"autofs",
"barrier",
"base-devel",
"bash-language-server",
"bat",
"bibtool",
"bind",
"blockdiag",
"boost",
"brightnessctl",
"btrfsmaintenance",
"calf",
"caps-lv2-git",
"carla",
"celluloid",
"cmake",
"cmt",
"conky",
"darktable",
"dialog",
"distrho-ports",
"dmidecode",
"dnsmasq",
"docker",
"docker-compose",
"dragonfly-reverb",
"epson-inkjet-printer-escpr2",
"exa",
"faad2",
"fd",
"feh",
"ffmpegthumbnailer",
"ffmpegthumbnailer",
"firewalld",
"fmit",
"fzf",
"gcc-libs",
"gendesk",
"git",
"git-filter-repo",
"git-lfs",
"gitflow-avh",
"gitflow-zshcompletion-avh",
"glibc",
"glow",
"gnu-free-fonts",
"gnuplot",
"google-chrome",
"graphicsmagick",
"grsync",
"gst-libav",
"gst-plugins-bad",
"gtk-engine-murrine",
"gtksourceview3",
"gtkspell3",
"guake",
"guitarix",
"helm-synth",
"help2man",
"helvum",
"htop",
"hunspell",
"hydrogen",
"i3-gaps",
"iftop",
"imlib2",
"intersect.lv2-git",
"iotop",
"ir.lv2",
"jack-audio-tools-carla",
"jack-audio-tools-common",
"jack-audio-tools-dbus",
"jack-audio-tools-lv2",
"jack-audio-tools-transport",
"jack-example-tools",
"jack-keyboard",
"jack-rack",
"jack_capture",
"jack_mixer",
"jack_utils",
"jansson",
"japa",
"jconvolver",
"jgmenu",
"jkmeter",
"jq",
"kitty",
"kitty-terminfo",
"kvantum-qt5",
"kvantum-theme-materia",
"ladspa",
"libbluray",
"libev",
"libgit2",
"libgme",
"libmad",
"libnm",
"libnma",
"libopusenc",
"libsamplerate",
"libvdpau-va-gl",
"libxcrypt-compat",
"libxml2",
"libzip",
"lightdm-gtk-greeter",
"lnav",
"lsyncd",
"lua",
"lv2",
"man-db",
"man-pages",
"mdadm",
"mediainfo",
"mixxx",
"mlocate",
"mod-utilities-lv2-git",
"mpv",
"mpv-plugin-excerpt-git",
"ncurses",
"neofetch",
"neovim",
"neovim-symlinks",
"nerd-fonts-hack",
"nerd-fonts-mononoki",
"net-tools",
"network-manager-applet",
"networkmanager",
"networkmanager-openconnect",
"networkmanager-openvpn",
"networkmanager-pptp",
"networkmanager-vpnc",
"nfs-utils",
"nitrogen",
"njconnect",
"nm-connection-editor",
"nodejs-lts-gallium",
"noise-repellent",
"nomacs",
"non-sequencer",
"notification-daemon",
"noto-fonts",
"npm",
"numix-circle-icon-theme-git",
"numlockx",
"nwdiag",
"ocenaudio-bin",
"opendesktop-fonts",
"openssl",
"opus",
"opusfile",
"osc2midi",
"osync",
"otf-font-awesome",
"pandoc",
"paper-icon-theme-git",
"pcmanfm",
"pdfjs",
"picom",
"pipewire",
"pipewire-alsa",
"pipewire-jack",
"pipewire-media-session",
"pipewire-pulse",
"pipewire-v4l2",
"pipewire-zeroconf",
"polybar",
"poppler",
"psi-plugins.lv2-git",
"python-adblock",
"python-pillow-simd",
"python-pip",
"python-pymupdf",
"qmidiarp",
"qmidinet",
"qpdfview",
"qpwgraph",
"qscintilla-qt5",
"r",
"qt5-base",
"qt5-tools",
"qt5ct",
"qt6-base",
"qt6-declarative",
"qt6-multimedia",
"qt6-tools",
"quickswitch-i3",
"qutebrowser",
"radiotray-ng",
"s",
"ranger",
"ripgrep-all",
"rofi",
"rsync",
"rtirq",
"rtkit",
"ruby-bundler",
"rubygems",
"samba",
"scala-music",
"scala-music-scales",
"screen",
"seqdiag",
"sfizz",
"smartmontools",
"sndio",
"songrec",
"sooperlooper",
"sox",
"sox-noise-git",
"sqlite",
"stochas",
"stunnel",
"stunnel",
"sudo",
"suil",
"swh-lv2-git",
"swh-plugins",
"taglib",
"terminator",
"terminus-font",
"tesseract",
"thunar",
"thunar-archive-plugin",
"thunar-volman",
"timeshift",
"timidity++",
"tmux",
"tonespace",
"ttf-bitstream-vera",
"ttf-caladea",
"ttf-carlito",
"ttf-croscore",
"ttf-dejavu",
"ttf-devicons",
"ttf-font-awesome-4",
"ttf-input",
"ttf-jetbrains-mono",
"ttf-liberation",
"ttf-nerd-fonts-symbols",
"ttf-opensans",
"ttf-ubuntu-font-family",
"ttf-unifont",
"tuna",
"tuned",
"vamp-plugin-sdk",
"vital-synth",
"vmpk",
"w3m",
"waf",
"wavpack",
"wmctrl",
"wol",
"wordnet-cli",
"x42-plugins",
"xarchiver",
"xbindkeys_config-gtk2",
"xdot",
"xdotool",
"xf86-video-intel",
"xkill-shortcut",
"xorg-fonts-alias-75dpi",
"xorg-fonts-alias-100dpi",
"xorg-fonts-alias-cyrillic",
"xorg-fonts-alias-misc",
"xorg-mkfontscale",
"xorg-xev",
"xorg-xinput",
"xorg-xlsfonts",
"xorg-xmodmap",
"xorg-xrandr",
"xorg-xrdb",
"xterm",
"xz",
"xzgv",
"youtube-dl",
"zim",
"zita-ajbridge",
"zita-alsa-pcmi",
"zita-lrx",
"zlib",
"zsh",
"zsh-autosuggestions",
"zsh-completions",
"zsh-history-substring-search",
"zsh-syntax-highlighting",
"zsh-theme-powerlevel10k"
]



packages.each do |package|
  aur_package_list = File.join(Dir.pwd, "aur.txt")

  info = `pamac info #{package} | grep -E "Repository|Groups" |awk -F ':' '{print $2}'`

  repo_group = info.strip.split("\n")

  puts "#{repo_group[0]} #{repo_group[1]} #{package}\n"

  begin
    TTY::File.append_to_file("fuck.txt", "#{repo_group[0].strip} #{repo_group[1].strip} #{package}\n", force: false)
  rescue StandardError => e
    puts "#{e}"
    next
  end
  #
  # if repo != "AUR"
  #   puts "#{package} is in #{repo.chomp}\n"
  #
  # end


  # unless repo == 'AUR'
  #   puts "#{package} is in #{repo}\n"
  #   TTY::File.append_to_file(pacman_package_list, "#{package}\n", force: false)
  # end
end
