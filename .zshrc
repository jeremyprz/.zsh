#!/bin/zsh
export DISABLE_AUTO_UPDATE="true"

[ ! -f ~/.oh-my-zsh/custom/themes/organl.zsh-theme ] && ~/.zsh/bin/install-organl-zsh-theme

if [ -d $HOME/.oh-my-zsh ]; then
  [ -z "$ZSH_THEME" ] && ZSH_THEME="organl"
  ZSH=$HOME/.oh-my-zsh
  # see: ~/.oh-my-zsh/plugins/*
  plugins=(git textmate sublime docker)
  source $HOME/.oh-my-zsh/oh-my-zsh.sh
fi

umask 022

if [ -d /Library/Java/JavaVirtualMachines ]; then
    OPEN_JDK=`find /Library/Java/JavaVirtualMachines -name 'adoptopenjdk*' -depth 1 | sort | tail -1`
fi
if [ -d "${OPEN_JDK}" ]; then
    export JDK_VERSION=`echo $OPEN_JDK | sed 's/.*\///'`
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/$JDK_VERSION/Contents/Home
    export PATH=${JAVA_HOME}/bin:${PATH}
elif [ -d /Library/Java/JavaVirtualMachines ]; then
    export JDK_VERSION=`ls -a /Library/Java/JavaVirtualMachines | sort | tail -1`
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/$JDK_VERSION/Contents/Home
    export PATH=${JAVA_HOME}/bin:${PATH}
fi
[ -d "$JAVA_HOME" ] && [ -f /bin/launchctl ] && /bin/launchctl setenv JAVA_HOME ${JAVA_HOME}

if [ -d ~/Library/Python/2.7/bin ]; then
    export PYTHON_27_HOME=~/Library/Python/2.7
    export PATH=${PATH}:$PYTHON_27_HOME/bin
fi

if [ -d /opt/maven ]; then
    export M2_HOME=/opt/maven
    export PATH=${M2_HOME}/bin:${PATH}
    [ -f /bin/launchctl ] && /bin/launchctl setenv M2_HOME ${M2_HOME}
fi

if [ -d /opt/gradle ]; then
    export GRADLE_HOME=/opt/gradle
    export PATH=${GRADLE_HOME}/bin:${PATH}
    [ -f /bin/launchctl ] && /bin/launchctl setenv GRADLE_HOME ${GRADLE_HOME}
fi

[ -d /sbin ] && PATH=/sbin:${PATH}
[ -d /snap/bin ] && PATH=/snap/bin:${PATH}
[ ! -d ~/bin ] && mkdir ~/bin
PATH=~/bin:"${PATH}"
[ -d ~/man ] && MANPATH=~/man:"${MANPATH}"
[ -d ~/dev/sandbox ] && cd ~/dev/sandbox
[ -f ~/.env/init.zsh ] && source ~/.env/init.zsh
[ -f ~/.zsh/.zsh-history ] && source ~/.zsh/.zsh-history
[ -f ~/.zshlogin ] && source ~/.zshlogin
[ -d ~/.toolbox/bin ] && PATH=~/.toolbox/bin:${PATH}
[ -d ~/.local/bin ] && PATH=~/.local/bin:${PATH}

# Projects which may or may not be installed
[ -d ~/dev/relay/bin ] && export PATH=$PATH:~/dev/relay/bin

# Colorized man pages
man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
		man "$@"
}

export PATH=$HOME/.toolbox/bin:$PATH
