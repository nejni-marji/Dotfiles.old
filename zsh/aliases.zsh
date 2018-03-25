#!/bin/zsh

alias t='todo.sh -d ~/Sync/todo/config'

alias freq='sort -n | uniq -c | sort -n'
alias freql='sort -n | uniq -c | sort -nr | less'

alias startx='ssh-agent startx'
alias rm='echo pls dont'
alias rmtrue='unalias rm'
alias rmfalse="alias rm='echo pls dont'"
alias mpcs='mpc -h odroid'

alias avahi-up='sudo systemctl start avahi-daemon; pulseaudio --kill; pulseaudio --start'
alias avahi-down='sudo systemctl stop avahi-daemon; pulseaudio --kill; pulseaudio --start'

alias man='man -P less'
alias feh='feh -dF'
alias pacman='pacman --color=auto'
alias pacaur='pacaur --color=auto'
alias grep='grep --color=auto'
alias gerp='grep'

alias i3ctl='i3-msg -s $XDG_RUNTIME_DIR/i3/ipc-socket.$(pgrep -x i3)'

alias rsync='rsync -a'
alias cp='rsync'
alias scp='rsync'

#alias ls='ls -F --group-directories-first'
alias ls='ls -F --color=auto --group-directories-first'
alias ll='ls -l'
alias la='ls -A'
alias laa='ls -a'
alias lla='ls -lA'
alias llaa='ls -la'

alias ydl="youtube-dl --restrict-filenames -o '%(title)s-%(id)s.%(format_id)s.%(ext)s'"
alias ydl18="youtube-dl --restrict-filenames -f 18 -o '%(title)s-%(id)s.%(format_id)s.%(ext)s'"
alias ydlx="youtube-dl --restrict-filenames -o '%(extractor)s_%(title)s-%(id)s.%(format_id)s.%(ext)s'"

alias :q='exit'
alias :qa='exit'

alias hide='hidehist on'
alias unhide='hidehist off'
alias ishide='hidehist'

alias alarm='echo -ne "\a"'
alias subs='subliminal download -l en'
alias updates='checkupdates && cower -u --ignore "libc++,libc++abi"'
alias tags_backup='rsync -av --exclude=deletos/\* ~/Media/Archive/ odroid:Media/Archive/'

alias vpn-up='sudo -k systemctl start openvpn-client@AirVPN.service'
alias vpn-down='sudo -k systemctl stop openvpn-client@AirVPN.service'

alias data='for i in *; do du -hs $i; done | sort -n'
alias datag="data | grep 'G\s'"
alias datadot='for i in * .*; do du -h $i | tail -n1; done | sort -n'

alias tgcli='telegram-cli -W'

# git aliases
alias gst='git status'
alias gcm='git commit'
alias gdf='git diff'
alias gsh='git stash'
alias gaa='git add -A'
