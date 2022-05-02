#!/bin/zsh

# GPG and SSH config
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# OHMYZSH and POWERLEVEL10K Config
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
ZSH_DISABLE_COMPFIX=true
export TERM="xterm-256color"
export ZSH="/Users/$(whoami)/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
unset POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND
source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme

# Built in config
DEFAULT_USER=whoami

# RBENV
export PATH="$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init -)"

# Homebrew path
export PATH="/usr/local/sbin:$PATH"

# Application Configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ ! -f /usr/local/opt/asdf/libexec/asdf.sh ]] || . /usr/local/opt/asdf/libexec/asdf.sh
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
export BAT_THEME="Dracula"

# Extend TMUX History File
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
export GPG_TTY=$(tty)

# Aliases
alias git="hub"
alias ll="ls -lah"
alias k="kubectl"
alias cat="bat --style=plain"
alias grep="rg"

# Personal Stuff
source ~/functions.sh
test -f ~/secrets.sh && source ~/secrets.sh
export AWS_PAGER=""

source <(kubectl completion zsh)
