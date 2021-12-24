# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r '${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh' ]]; then
  source '${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh'
fi

USE_POWERLINE="true"
## Options section
# Auto correct mistakes
setopt correct
# Extended globbing. Allows using regular expressions with *
setopt extendedglob

# Case insensitive globbing
setopt nocaseglob

# Array expension with parameters
setopt rcexpandparam

# Don't warn about running processes when exiting
setopt nocheckjobs

# Sort filenames numerically when it makes sense
setopt numericglobsort
# No beep
setopt nobeep

# Immediately append history instead of overwriting
setopt appendhistory

# If a new command is a duplicate, remove the older one
setopt histignorealldups

# if only directory path is entered, cd there.
setopt autocd

# save commands are added to the history immediately, otherwise only when shell exits.
setopt inc_append_history

# Case insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'

# automatically find new executables in path
zstyle ':completion:*' rehash true
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
#export EDITOR=/usr/bin/nano
#export VISUAL=/usr/bin/nano
# Don't consider certain characters part of the word
WORDCHARS=${WORDCHARS//\/[&.;]}


## Keybindings section
bindkey -e
# Home key
bindkey '^[[7~' beginning-of-line
# Home key
bindkey '^[[H' beginning-of-line

# [Home] - Go to beginning of line
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line
fi

# End key
bindkey '^[[8~' end-of-line

# End key
bindkey '^[[F' end-of-line

# [End] - Go to end of line
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line
fi

# Insert key
bindkey '^[[2~' overwrite-mode
# Delete key
bindkey '^[[3~' delete-char
# Right key
bindkey '^[[C'  forward-char
# Left key
bindkey '^[[D'  backward-char
# Page up key
bindkey '^[[5~' history-beginning-search-backward
# Page down key
bindkey '^[[6~' history-beginning-search-forward

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word
bindkey '^[Od' backward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
# delete previous word with ctrl+backspace
bindkey '^H' backward-kill-word
# Shift+tab undo last action
bindkey '^[[Z' undo

## Alias section
# Confirm before overwriting something
alias cp="cp -i"
# Human-readable sizes
alias df='df -h'
# Show sizes in MB
alias free='free -m'
alias gitu='git add . && git commit && git push'

alias ll="exa -alH --group-directories-first -s time -t modified"
alias checklog='journalctl -o short-iso | lnav'
alias taillog='journalctl -f | lnav'

alias cat="bat"

alias h="history 1"

# Theming section
autoload -U compinit colors zcalc
compinit -d
colors

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R


## Plugins section: Enable fish style features
# Use syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Use history substring search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Offer to install missing package if command is not found
if [[ -r /usr/share/zsh/functions/command-not-found.zsh ]]; then
    source /usr/share/zsh/functions/command-not-found.zsh
    export PKGFILE_PROMPT_INSTALL_MISSING=1
fi

# Set terminal window and tab/icon title
#
# usage: title short_tab_title [long_window_title]
#
# See: http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss3.1
# Fully supports screen and probably most modern xterm and rxvt
# (In screen, only short_tab_title is used)
function title {
  emulate -L zsh
  setopt prompt_subst

  [[ "$EMACS" == *term* ]] && return

  # if $2 is unset use $1 as default
  # if it is set and empty, leave it as is
  : ${2=$1}

  case "$TERM" in
    xterm*|putty*|rxvt*|konsole*|ansi|mlterm*|alacritty|st*|terminator)
      # set window name
      print -Pn "\e]2;${2:q}\a"
      # set tab name
      print -Pn "\e]1;${1:q}\a"
      ;;
    screen*|tmux*)
      print -Pn "\ek${1:q}\e\\" # set screen hardstatus
      ;;
    *)
    # Try to use terminfo to set the title
    # If the feature is available set title
    if [[ -n "$terminfo[fsl]" ]] && [[ -n "$terminfo[tsl]" ]]; then
      echoti tsl
      print -Pn "$1"
      echoti fsl
    fi
      ;;
  esac
}

#15 char left truncated PWD
ZSH_THEME_TERM_TAB_TITLE_IDLE="%15<..<%~%<<"
ZSH_THEME_TERM_TITLE_IDLE="%n@%m:%~"

# Runs before showing the prompt
function mzc_termsupport_precmd {
  [[ "${DISABLE_AUTO_TITLE:-}" == true ]] && return
  title $ZSH_THEME_TERM_TAB_TITLE_IDLE $ZSH_THEME_TERM_TITLE_IDLE
}

# Runs before executing the command
function mzc_termsupport_preexec {
  [[ "${DISABLE_AUTO_TITLE:-}" == true ]] && return

  emulate -L zsh

  # split command into array of arguments
  local -a cmdargs
  cmdargs=('${(z)2}')
  # if running fg, extract the command from the job description
  if [[ "${cmdargs[1]}" = fg ]]; then
    # get the job id from the first argument passed to the fg command
    local job_id jobspec="${cmdargs[2]#%}"
    # logic based on jobs arguments:
    # http://zsh.sourceforge.net/Doc/Release/Jobs-_0026-Signals.html#Jobs
    # https://www.zsh.org/mla/users/2007/msg00704.html
    case "$jobspec" in
      <->) # %number argument:
        # use the same <number> passed as an argument
        job_id=${jobspec} ;;
      ""|%|+) # empty, %% or %+ argument:
        # use the current job, which appears with a + in $jobstates:
        # suspended:+:5071=suspended (tty output)
        job_id=${(k)jobstates[(r)*:+:*]} ;;
      -) # %- argument:
        # use the previous job, which appears with a - in $jobstates:
        # suspended:-:6493=suspended (signal)
        job_id=${(k)jobstates[(r)*:-:*]} ;;
      [?]*) # %?string argument:
        # use $jobtexts to match for a job whose command *contains* <string>
        job_id=${(k)jobtexts[(r)*${(Q)jobspec}*]} ;;
      *) # %string argument:
        # use $jobtexts to match for a job whose command *starts with* <string>
        job_id=${(k)jobtexts[(r)${(Q)jobspec}*]} ;;
    esac

    # override preexec function arguments with job command
    if [[ -n "${jobtexts[$job_id]}" ]]; then
      1="${jobtexts[$job_id]}"
      2="${jobtexts[$job_id]}"
    fi
  fi

  # cmd name only, or if this is sudo or ssh, the next cmd
  local CMD=${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}
  local LINE="${2:gs/%/%%}"

  title '$CMD' '%100>...>$LINE%<<'
}

autoload -U add-zsh-hook
add-zsh-hook precmd mzc_termsupport_precmd
add-zsh-hook preexec mzc_termsupport_preexec

# Apply different settigns for different terminals
case $(basename "$(cat "/proc/$PPID/comm")") in
  login)
      source /usr/share/zsh/zsh-maia-prompt
    	alias x='startx ~/.xinitrc'
    ;;
  *)
      if [[ $TERM == "linux" ]]; then
        # TTY does not have powerline fonts
        source /usr/share/zsh/zsh-maia-prompt
        alias x='startx ~/.xinitrc'
      elif [[ "$USE_POWERLINE" == "true" ]]; then
        # Use powerline
        source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
        [[ ! -f /usr/share/zsh/p10k.zsh ]] || source /usr/share/zsh/p10k.zsh
        source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
        ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
      else
        # Don't use powerline anyway
        source /usr/share/zsh/zsh-maia-prompt
        source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
        ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
      fi
    ;;
esac

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
