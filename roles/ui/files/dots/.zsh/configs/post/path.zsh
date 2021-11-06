# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:$HOME/.local/bin:/usr/local/sbin:$PATH"
PATH="$PATH:/opt/sonic-pi/bin"
PATH="$PATH:$HOME/.gem/ruby/3.0.0/bin"
PATH="$PATH:$JAVA_HOME/bin"
PATH="$PATH:$SOUNDBOT/bin"
#source $HOME/.config/git-subrepo/.rc
export -U PATH
