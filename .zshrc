#!/bin/zsh
export HOSTNAME=`hostname -s`
export DISABLE_AUTO_UPDATE="true"

[ -f /apollo/env/envImprovement/var/zshrc ] && . /apollo/env/envImprovement/var/zshrc

if [ -d $HOME/.oh-my-zsh ] && [ "$ZSH_THEME" != "vcs_info" ]; then
  [ -z "$ZSH_THEME" ] && ZSH_THEME="dstufft"
  ZSH=$HOME/.oh-my-zsh
  # see: ~/.oh-my-zsh/plugins/*
  plugins=(git textmate)
  source $HOME/.oh-my-zsh/oh-my-zsh.sh
fi

umask 022

if [ -d /Library/Java/JavaVirtualMachines ]; then
    export JDK_VERSION=`ls -a /Library/Java/JavaVirtualMachines | sort | tail -1`
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/$JDK_VERSION/Contents/Home
fi

# History
setopt APPEND_HISTORY
## for sharing history between zsh processes
#setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
export HISTSIZE=1000
export SAVEHIST=1000

h() { if [ -z "$*" ]; then history 1; else history 1 | egrep "$@"; fi; }

[ -d ~/bin ] && PATH=~/bin:"${PATH}"
[ -d ~/man ] && MANPATH=~/man:"${MANPATH}"

[ -d ~/dev/sandbox ] && cd ~/dev/sandbox

[ -f ~/.zshlogin ] && source ~/.zshlogin
