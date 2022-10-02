#!/bin/zsh

export PATH=${PATH}:~/.zsh/bin
umask 022

if [ -d /Library/Java/JavaVirtualMachines ]; then
    JDKS=/Library/Java/JavaVirtualMachines
elif [ -d /opt/jvm ]; then
    JDKS=/opt/jvm
else
    JDKS=~/.zsh/.zshrc/unable/to/find/jdks
fi 

if [ -d ${JDKS} ]; then
    JDK=`ls ${JDKS} | grep -E 'amazon-corretto-([0-9]+)\.jdk' | sort -V | tail -1`
    if [ -d ${JDKS}/${JDK}/bin ]; then
        JAVA_HOME=${JDKS}/${JDK}
    elif [ -d ${JDKS}/${JDK}/Contents/Home ]; then
        JAVA_HOME=${JDKS}/${JDK}/Contents/Home
    fi
    export PATH=${JAVA_HOME}/bin:${PATH}
fi
[ -d "$JAVA_HOME" ] && [ -f /bin/launchctl ] && /bin/launchctl setenv JAVA_HOME ${JAVA_HOME}

if [ -d /opt/homebrew/bin ]; then
    # Prioritize Homebrew over rest of path
    export PATH=/opt/homebrew/bin:${PATH}
elif [ -d ~/.linuxbrew/bin ]; then
    export PATH=~/.linuxbrew/bin:${PATH}
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

# log4j JNDI fixes
export JAVA_TOOLS_OPTIONS="-Dlog4j2.formatMsgNoLookups=true"

export DISABLE_AUTO_UPDATE="true"

[ ! -f ~/.oh-my-zsh/custom/themes/organl.zsh-theme ] && ~/.zsh/init/install-organl-zsh-theme

if [ -d $HOME/.oh-my-zsh ]; then
  [ -z "$ZSH_THEME" ] && ZSH_THEME="organl"
  ZSH=$HOME/.oh-my-zsh
  # see: ~/.oh-my-zsh/plugins/*
  plugins=(
    git
    git-auto-fetch
    git-prompt
    colored-man-pages
    textmate 
    sublime 
    docker 
    tmux 
    vscode)
  source $HOME/.oh-my-zsh/oh-my-zsh.sh
fi

fpath=(~/.zsh/completion $fpath)
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit -i

if [ -f "$(which aws_completer)" ]; then
  complete -C "$(which aws_completer)" aws
fi