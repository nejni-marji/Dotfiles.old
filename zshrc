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
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS

# prompt
setopt PROMPT_SUBST

source ~/Dotfiles/extras/zsh-git-prompt/zshrc.sh
source ~/Dotfiles/zsh/pwd_shorten.sh
PROMPT=\
'%f%k'\
'%B%F{magenta}'\
'%D{%a, %b %-d, %H:%M:%S}'\
'%b%f%k'\
$'\n'\
'%(1000#.%F{white}%K{blue}.%F{black}%K{red})'\
's%Le%? %n@%M'\
'%f%k'\
$'\n'\
'%F{cyan}$(pwds_status)%f'\
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
