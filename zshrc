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

source ~/Dotfiles/extras/zsh-git-prompt/zshrc.sh
PROMPT=\
'%f%k'\
'%F{white}%K{blue}'\
's%Le%? %n@%M'\
'%f%k'\
$'\n'\
'%F{cyan}%~%f'\
$'\n'\
'$(git_super_status)%F{cyan}$(hidehist)%(#.#.%%)%f '\
''

source ~/.zshenv
source ~/.zsh/zstyles.zsh

# zbell.sh
source ~/Dotfiles/extras/zbell.sh

# source aliases and commands
source ~/.zsh/aliases.zsh
source ~/.zsh/commands.zsh
source ~/.zsh/terminals.zsh
