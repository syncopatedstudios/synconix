# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:$HOME/.local/bin:/usr/local/sbin:$PATH"

PATH="$PATH:/opt/soundbot/robotstuff/bin"

PATH="$PATH:$HOME/.cargo/bin"
PATH="$PATH:/opt/sonic-pi/bin"
PATH="$PATH:/opt/sononym"

PATH="$PATH:$JAVA_HOME/bin"
PATH="$PATH:$SOUNDBOT/bin"
PATH="$PATH:/usr/lib/surfraw"
PATH="$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin"
PATH="$PATH:$HOME/.rvm/bin"

export -U PATH
