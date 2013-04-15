# colors
autoload -U colors
colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export CLICOLOR=1

# prompt
setopt prompt_subst
autoload -U promptinit
promptinit

source /usr/local/etc/bash_completion.d/git-prompt.sh
PROMPT='%{$fg_bold[cyan]%}%c%{$reset_color%}%{$fg_bold[white]%}$(__git_ps1)%{$reset_color%} %# '
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"

# completion
autoload -U compinit
compinit
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} l:|=* r:|=*'

# path
cdpath=(~ ~/projects)

# history
HISTFILE=$HOME/.history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt inc_append_history
h () { history 0 | grep $1 } # grep history

# editor
export EDITOR=vi

# alias
alias gst='git status'
alias g=gst
alias gc='git commit'
alias gco='git checkout'
alias gl='git pull'
alias gp='git push'
alias gd='git diff'
alias gdc='git diff --cached'
alias gaa='git add --all'

alias rgm='rails g model'
alias rgc='rails g controller'

alias ll='ls -al'

