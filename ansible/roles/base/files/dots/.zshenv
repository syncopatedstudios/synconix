export TEMP="/tmp"

export TERM="kitty"
export TERMINAL="kitty"
export TERMINFO="/usr/lib/terminfo"
export TERMCMD="$TERMINAL"

export BROWSER="google-chrome-stable"

if [ -x "$(command -v most)" ]; then
  export PAGER=most
else
  echo "most is not installed, using less..."
  export PAGER=less
fi

export VAMP_PATH="$HOME/.vamp"

export LADSPA_PATH="/usr/lib/ladspa:/usr/local/lib/ladspa"
export LADSPA_RDF_PATH="/usr/share/ladspa/rdf"

export ECASOUND=ecasound

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

export DISABLE_AUTO_TITLE=true

export HOSTNAME=`hostnamectl --static`

##################################
#  synconix elements
##################################
export WORKSPACE="$HOME/Workspace"

export ANSIBLE_HOME="$WORKSPACE/synconix/ansible"
export ANSIBLE_CONFIG="$ANSIBLE_HOME/ansible.cfg"

export SOUNDS="$HOME/Library/Sounds"
export SOUNDFONTS="$LIBRARY/Soundfonts"

export STUDIO="$HOME/Studio"
export PROJECTS="$STUDIO/projects"

##################################
#  graphical elements
##################################

export NO_AT_BRIDGE=1

export QT_SCALE_FACTOR=1.0
export QT_FONT_DPI=96

export NODE_PATH=/usr/lib/node_modules

export XDG_DATA_DIRS="/usr/local/share/:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"

# export PIPEWIRE_LOG_SYSTEMD=false
