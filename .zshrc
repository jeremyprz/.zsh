#!/bin/zsh
export HOSTNAME=`hostname -s`
export DISABLE_AUTO_UPDATE="true"

[ -f /apollo/env/envImprovement/var/zshrc ] && . /apollo/env/envImprovement/var/zshrc

if [ -d $HOME/.oh-my-zsh ] && [ "$ZSH_THEME" != "vcs_info" ]; then
  [ -z "$ZSH_THEME" ] && ZSH_THEME="dstufft"
  ZSH=$HOME/.oh-my-zsh
  # see: ~/.oh-my-zsh/plugins/*
  plugins=(git textmate sublime docker)
  source $HOME/.oh-my-zsh/oh-my-zsh.sh
fi

umask 022

if [ -d /Library/Java/JavaVirtualMachines ]; then
    export JDK_VERSION=`ls -a /Library/Java/JavaVirtualMachines | sort | tail -1`
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/$JDK_VERSION/Contents/Home
    export PATH=${JAVA_HOME}/bin:${PATH}
    [ -f /bin/launchctl ] && /bin/launchctl setenv JAVA_HOME ${JAVA_HOME}
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

[ ! -d ~/bin ] && mkdir ~/bin
PATH=~/bin:"${PATH}"
[ -d ~/man ] && MANPATH=~/man:"${MANPATH}"
[ -d ~/dev/sandbox ] && cd ~/dev/sandbox
[ -f ~/.zsh/.zsh-history ] && source ~/.zsh/.zsh-history
[ -f ~/.zshlogin ] && source ~/.zshlogin

sun=☉
earth=♁
cloud=☁
atom=⚛
neptune=♆
airplane=✈︎

case `hostname -s` in
    "f45c89a3afa7") 
        location=$airplane
        ;;
    "dev-dsk-przasnys-m4xl-i-34f5ceef") 
        location=$cloud
        ;;
    "kramer") 
        location=$earth
        ;;
    "hackintosh") 
        location=$neptune
        ;;
    *)
        location="¿"
        ;;
esac

function get_pwd() {
  echo "${PWD/$HOME/~}"
}

PROMPT='
$fg[cyan]$location $fg[yellow]$(get_pwd)
$reset_color$(prompt_char) '

