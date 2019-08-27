# aliases
# source <(curl -s https://github.com/jackkenlay/setup/blob/master/bash_profile/.bash_profile)

alias ll="ls -lhA"                                      #Preferred 'ls' implimentation
alias "ij=open -a /Applications/IntelliJ\ IDEA.app" #Opens intelli J
alias f='open -a Finder ./'                             #Opens finder in current location
alias "vs=open -a /Applications/Visual\ Studio\ Code.app/"
alias gp="doubleGitPull"
alias chrome-unsafe='open -a Google\ Chrome --args --disable-web-security --user-data-dir' #Open up XSS Chrome

kill-all() {
# Needs researching
  echo "Killing all"
  kill -9 -1
}

kill-jars() {
  echo "Killing all Java Processes"
  # pkill -f 'java -jar'
  killall -9 java
}

doubleGitPull() {
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

M3_HOME=/usr/local/bin/apache-maven-3.5.2
export M3_HOME

# Test
M2_HOME=/usr/local/bin/apache-maven-3.5.2
export M2_HOME

PATH=$PATH:$HOME/.local/bin:$HOME/bin:$JAVA_HOME/bin:$M2_HOME/bin
export PATH

PATH=$PATH:$HOME/.local/bin:$HOME/bin:$JAVA_HOME/bin:$M3_HOME/bin
export PATH


#Java
#http://davidcai.github.io/blog/posts/install-multiple-jdk-on-mac/
# Init jenv
if which jenv > /dev/null; then eval "$(jenv init -)"; fi
export JAVA_HOME=$(/usr/libexec/java_home)

add-new-card(){
  # get current card
  newCard=0;
  for d in */ ; do
    # echo "$d" | sed 's/[^0-9]*//g'
    
    cardNumber=`echo "$d" | sed 's/[^0-9]*//g'`;
    # echo "$cardNumber";
    newCard=`echo "$(($cardNumber + 1))"`;

  done
  newCardDir="card-"$newCard;

  mkdir -p $newCardDir;
  touch "./$newCardDir/front.html";
  touch "./$newCardDir/back.html";
}