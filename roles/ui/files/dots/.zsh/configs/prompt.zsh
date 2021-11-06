
setopt promptsubst

# Allow exported PS1 variable to override default prompt.
# if ! env | grep -q '^PS1='; then
#   PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%c%{$reset_color%}$(git_prompt_info) %# '
# fi
