# ------------------------------------------------------------------------------
#          FILE:  minimal-terminal-prompt.zsh-theme
#   DESCRIPTION:  oh-my-zsh theme file to show simple git status
#        AUTHOR:  Alicia Sykes (alicia@as93.net)
#       VERSION:  1.0.0
#    SCREENSHOT:  screenshot.gif
#          REPO:  https://github.com/Lissy93/minimal-terminal-prompt
#   DIRECT LINK:  https://raw.githubusercontent.com/Lissy93/minimal-terminal-prompt/master/minimal-terminal-prompt.zsh-theme
# ------------------------------------------------------------------------------



# color vars
eval col_gray='$FG[240]'
eval col_yellow='$FG[214]'
eval col_primary='$FG[032]'
eval col_diff='$FG[214]'
eval col_diff='$FG[214]'
eval col_same='$FG[034]'
eval col_red='$FG[124]'
eval col_purple='$FG[093]'

HOSTNAME=$( cat /etc/hostname )

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

case $HOSTNAME in
	crambot)
		eval col_host='$FG[222]'
		;;
	lapbot)
		eval col_host='$FG[022]'
		;;
esac

if [ $UID -eq 0 ];
then
	PROMPT='$col_red%n@%m%{$reset_color%} [$col_gray%~%{$reset_color%}]%'
else
# primary prompt
PROMPT='$col_purple% ├
$col_purple% │%{$reset_color%}$col_gray%~\
$(git_prompt_info) %{$reset_color%}[@%{$col_host%}%m%{$reset_color%}] \
$col_gray%(?.%{$col_purple%}.%{$col_diff%})
└─▶%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code}'
# right prompt
	if type "virtualenv_prompt_info" > /dev/null
	then
		RPROMPT='$(virtualenv_prompt_info)$col_gray%n@%m%{$reset_color%} [$(date +%H:%M)]%'
	else
		RPROMPT='$col_gray%n@%m%{$reset_color%} [$(date +%H:%M)]%%'
	fi
fi




# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$col_primary($col_same"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$col_diff+%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$col_primary)%{$reset_color%}"
