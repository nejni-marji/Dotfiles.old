#!/bin/zsh

# actual commands
alias startx='ssh-agent startx'
alias rm='echo pls dont'
alias man='man -P less'
alias pacman='pacman --color=auto'
alias pacaur='aurman --color auto'
alias grep='grep --color=auto'
alias rsync='rsync -a'
alias cp='rsync'
alias scp='rsync'

# ls
alias ls='ls -F --color=auto --group-directories-first'
alias ll='ls -l'
alias la='ls -A'
alias laa='ls -a'
alias lla='ls -lA'
alias llaa='ls -la'
alias lr='ls -R'
alias llr='ls -lR'
alias lsd='ls -d'

# miscellaneous shell stuff
alias :q='exit'
alias :qa='exit'

alias hide='hidehist on'
alias unhide='hidehist off'
alias ishide='hidehist'

alias alarm='echo -ne "\a"'
alias subs='subliminal download -l en'
alias updates='checkupdates'
alias tags_backup='rsync -av --exclude=deletos/\* ~/Media/Archive/ odroid:Media/Archive/'
alias i3ctl='i3-msg -s $XDG_RUNTIME_DIR/i3/ipc-socket.$(pgrep -x i3)'

alias freq='sort -n | uniq -c | sort -n'
alias freql='sort -n | uniq -c | sort -nr | less'

alias data='for i in *; do du -hs $i; done | sort -hr'
alias datag="data | grep 'G\s'"
alias datadot='for i in * .*; do du -h $i | tail -n1; done | sort -hr'

alias help='helptext.sh'

# youtube-dl
alias ydl="youtube-dl --restrict-filenames -o '%(title)s-%(id)s.%(format_id)s.%(ext)s'"
alias ydl18="youtube-dl --restrict-filenames -f 18 -o '%(title)s-%(id)s.%(format_id)s.%(ext)s'"
alias ydlx="youtube-dl --restrict-filenames -o '%(extractor)s_%(title)s-%(id)s.%(format_id)s.%(ext)s'"

# git aliases
alias g='git'
alias gs='git status'
alias gss='git status --short'
alias gd='git diff'
alias gsv='git status -v'
alias gdv='git diff -v'
alias gsh='git stash'
alias ga='git add'
alias gaa='git add -A'
alias gcm='git commit -m'
alias gpu='git push'
alias gch='git checkout'
alias gl='git log --color --decorate --oneline'
alias glh='git log --color --decorate --oneline | head'

alias gr='git rev-parse --show-toplevel >/dev/null && cd $(git rev-parse --show-toplevel)'

# typos
alias ccl='cl'
alias gerp='grep'

# abbreviations
alias h='help'
alias t='todo.sh -d ~/Sync/todo/config'
alias l='ls'
alias v='vim'
alias pm='pacman'
alias pa='pacauc'
alias wcl='wc -l'

# thefuck
eval $(thefuck --alias)
alias shit='fuck'
alias crap='fuck'
alias ffs='fuck'
alias wtf='fuck'
alias f='fuck'

# per-system aliases
[[ $(hostname -d) == Kubuntu ]] && alias todo.sh=todo-txt
