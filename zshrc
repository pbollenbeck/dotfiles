# colors
autoload -U colors
colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export CLICOLOR=1

# prompt
setopt prompt_subst
setopt prompt_percent
autoload -U promptinit
promptinit

source $HOME/.git-prompt.sh
# PS1='%{$fg_bold[cyan]%}%c%{$reset_color%}$(__git_ps1) %# '
precmd () { __git_ps1 "%{$fg_bold[cyan]%}%~%{$reset_color%} " "%# " "(%s) " }
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS=1

# completion
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} l:|=* r:|=*'

setopt nonomatch

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
export EDITOR=nvim

# alias
alias g='git status'
alias gc='git commit'
alias gco='git checkout'
alias gl='git pull'
alias gp='git push'
alias gd='git diff'
alias gdc='git diff --cached'
alias ga='git add'
alias gaa='git add --all'
alias glo="git log -30 --graph --pretty=format:'%h %ad %s (%an)' --date=short"
alias gbd="git branch -d"
alias gbl="git branch -l"

alias rdm='rake db:create db:migrate db:test:prepare'
alias ber='bundle exec rake'
alias bec='bundle exec cucumber'
alias be='bundle exec'

alias ll='ls -alF'
alias bu='brew update && brew upgrade && brew cleanup && asdf plugin update --all'

# switch off flow control to use CTRL-S and CTRL-Q (e.g. in command-t)
stty -ixon -ixoff

export PATH="/opt/homebrew/bin:/usr/local/sbin:$PATH"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
