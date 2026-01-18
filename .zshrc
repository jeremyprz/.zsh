#!/bin/zsh

export PATH=${PATH}:~/.zsh/bin
umask 0002

# https://stackoverflow.com/questions/62931101/i-have-multiple-files-of-zcompdump-why-do-i-have-multiple-files-of-these
export ZSH_COMPDUMP="~/.zsh/.cache/.zcompdump-${HOST}"

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

fexists() {
    target=$1
    if [[ -f $target || ( -L $target && -f $(readlink -f $target ) ) ]]; then
        return 0
    else
        return 1
    fi
}

[ -d /sbin ] && PATH=/sbin:${PATH}
[ -d /snap/bin ] && PATH=/snap/bin:${PATH}
[ ! -d ~/bin ] && mkdir ~/bin
PATH=~/bin:"${PATH}"
[ -d ~/man ] && MANPATH=~/man:"${MANPATH}"
[ -d /usr/local/opt/postgresql@17/bin ] && export PATH="/usr/local/opt/postgresql@17/bin:${PATH}"
[ -d ~/dev/sandbox ] && cd ~/dev/sandbox
[ -f ~/.env/init.zsh ] && source ~/.env/init.zsh
[ -f ~/.zsh/.zsh-history ] && source ~/.zsh/.zsh-history
[ -f ~/.zshlogin ] && source ~/.zshlogin
[ -d ~/.toolbox/bin ] && PATH=~/.toolbox/bin:${PATH}
[ -d ~/.local/bin ] && PATH=~/.local/bin:${PATH}
[ -d ~/dev/bin ] && PATH=~/dev/bin:${PATH}
if [[ -d ~/.pyenv ]]; then
    export PY_ENV_ROOT="~/.pyenv"
    export PATH="${PY_ENV_ROOT}/bin:$PATH"
    eval "$(pyenv init --path)"
fi
[ -d ~/.organl/bin ] && PATH=~/.organl/bin:${PATH}
[ -d ~/Dropbox/divorce/bin ] && PATH=~/Dropbox/divorce/bin:${PATH}
fexists ~/dev/olai/venv/olai/bin/activate && source ~/dev/olai/venv/olai/bin/activate
fexists ~/.gemini/.env && source ~/.gemini/.env


# log4j JNDI fixes
export JAVA_TOOLS_OPTIONS="-Dlog4j2.formatMsgNoLookups=true"

export DISABLE_AUTO_UPDATE="true"
export VIRTUAL_ENV_DISABLE_PROMPT="true"

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

# The next line updates PATH for the Google Cloud SDK.
fexists /private/tmp/google-cloud-sdk/path.zsh.inc && . /private/tmp/google-cloud-sdk/path.zsh.inc

# The next line enables shell command completion for gcloud.
fexists /private/tmp/google-cloud-sdk/completion.zsh.inc && . /private/tmp/google-cloud-sdk/completion.zsh.inc

# Google Cloud SDK
export GOOGLE_CLOUD_PROJECT="olai-prototype"

# opencode
[ -d ~/.opencode/bin ] && PATH=~/.opencode/bin:$PATH
