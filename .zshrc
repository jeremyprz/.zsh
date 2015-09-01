#!/bin/zsh
echo SOURCING .zshrc
export HOSTNAME=`hostname -s`

[ -f ~/.zshrc-local ] && . ~/.zshrc-local

if [ -d $HOME/.oh-my-zsh ] && [ "$ZSH_THEME" != "vcs_info" ]; then
  [ -z "$ZSH_THEME" ] && ZSH_THEME="dstufft"
  ZSH=$HOME/.oh-my-zsh
  # see: ~/.oh-my-zsh/plugins/*
  plugins=(git textmate)
  source $HOME/.oh-my-zsh/oh-my-zsh.sh
fi

[ -d ~/dev/sandbox ] && cd ~/dev/sandbox

# History
setopt APPEND_HISTORY
## for sharing history between zsh processes
#setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
export HISTSIZE=1000
export SAVEHIST=1000

