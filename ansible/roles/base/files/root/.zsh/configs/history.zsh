setopt hist_ignore_all_dups inc_append_history
setopt share_history

HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000

export ERL_AFLAGS="-kernel shell_history enabled"
