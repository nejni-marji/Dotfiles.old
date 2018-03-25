#!/bin/zsh
#
# ~/.zshrc
#

# misc options
setopt AUTO_CD
bindkey -v

# history
HISTFILE=~/.zsh_history
SAVEHIST=100000
HISTSIZE=100000
setopt INC_APPEND_HISTORY HIST_IGNORE_ALL_DUPS

# prompt
setopt PROMPT_SUBST

if [[ "$(hostname)" = "Raspi" ]]; then
PROMPT='%K{$P_COLOR}s%Le%? %n@%M%k
%F{$P_COLOR}%~%f
%F{$P_COLOR}$(hidehist)%(#.#.%%) %f'

else

source ~/Dotfiles/extras/zsh-git-prompt/zshrc.sh
#A='s%Le%?'
#B='%n@%M'
#C='%~'
#D='$(hidehist)%(#.#.%%)'
#P1=blue
#P2=cyan

#PROMPT="%f%k\
#%F{15}%K{\$P1}$A $B%f%k
#%F{\$P2}$C%f
#\$(git_super_status)\
#%F{\$P2}$D%f "

PROMPT='%f%k%F{15}%K{blue}s%Le%? %n@%M%f%k
%F{cyan}%~%f
$(git_super_status)%F{cyan}$(hidehist)%(#.#.%%)%f '

fi

source ~/.zshenv
source ~/.zsh/zstyles.zsh

# zbell.sh
source ~/Dotfiles/extras/zbell.sh

# source aliases and commands
source ~/.zsh/aliases.zsh
source ~/.zsh/commands.zsh
source ~/.zsh/terminals.zsh

## testing
##zstyle ":morpho" screen-saver "matrix"
#zstyle ":morpho" screen-saver "asciiquarium"
##zstyle ":morpho" arguments "-b -s -u 9"
#zstyle ":morpho" delay "179"
#zstyle ":morpho" check-interval "60"
#source ~/Dotfiles/extras/zsh-morpho/zsh-morpho.plugin.zsh
