# aliases
# source <(curl -s https://github.com/jackkenlay/setup/blob/master/bash_profile/.bash_profile)
echo "/Users/jackkenlay/personal/setup/bash_profile/.bash_profile"

alias ll="ls -lhA"                                      #Preferred 'ls' implimentation
alias "ij=open -a /Applications/IntelliJ\ IDEA\ CE.app" #Opens intelli J
alias f='open -a Finder ./'                             #Opens finder in current location
alias "vs=open -a /Applications/Visual\ Studio\ Code.app/"
alias gp="doubleGitPull"

# example function
example-function(){
  echo "example";
}

doubleGitPull(){
  echo "pulling thrice";
  git pull && git pull && git pull;
}
# colours
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# git autocomplete
# https://github.com/bobthecow/git-flow-completion/wiki/Install-Bash-git-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# git prompt
# https://github.com/magicmonty/bash-git-prompt
if [ -f /usr/local/share/gitprompt.sh ]; then
    GIT_PROMPT_THEME=Default
    . /usr/local/share/gitprompt.sh
fi


export JAVA_HOME=$(/usr/libexec/java_home)

M3_HOME=/usr/local/bin/apache-maven-3.5.2
export M3_HOME

PATH=$PATH:$HOME/.local/bin:$HOME/bin:$JAVA_HOME/bin:$M3_HOME/bin
export PATH
