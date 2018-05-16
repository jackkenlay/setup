# aliases
# source <(curl -s https://github.com/jackkenlay/setup/blob/master/bash_profile/.bash_profile)
echo "/Users/jackkenlay/personal/setup/bash_profile/.bash_profile"
echo "Alias' available:"
echo "f, ls, vs, ij, gp"

# echo "Pulling latest setup repo"
# cd ~/personal/setup && git pull && git pull && cd ~/



alias ll="ls -lhA"                                      #Preferred 'ls' implimentation
alias "ij=open -a /Applications/IntelliJ\ IDEA.app" #Opens intelli J
alias f='open -a Finder ./'                             #Opens finder in current location
alias "vs=open -a /Applications/Visual\ Studio\ Code.app/"
alias gp="doubleGitPull"

# example function
example-function(){
  echo "example";
}

kill-jars(){
  echo "Killing all Java Processes"
  pkill -f 'java -jar'
}

setup-camelot(){
   ## close all windows/process
   echo "Setting up Camelot"
   kill-jars
   echo "Opening JAR"
   open /System/Library/CoreServices/Jar\ Launcher.app/ ~/AEM/camelot_il_aem/cq-quickstart-p4502.jar 
   echo "Opening Notes"
   open -a /Applications/Notes.app/
   echo "Opening Mail"
   open -a /Applications/Mail.app/
   echo "Opening Slack"
   open -a /Applications/Slack.app/
   echo "Opening Spotify"
   open -a /Applications/Spotify.app/
   echo "Opening Skype"
   open -a /Applications/Skype.app/
   echo "Opening Chrome"
   open -a /Applications/Google\ Chrome.app/
   echo "Waiting for Jar to finish booting up"
   sleep 30
   echo "Opening IJ"
   cd ~/work/illinois-aem/ && ll && ij .
   echo "Npm Install"
   cd ~/work/illinois-aem/ui.apps/src/main/ && npm install && npm run build && cd ~/work/illinois-aem/ && ll
   echo "Maven Install"
   mvn clean install -PautoInstallPackage
   #open second terminal
   echo "Opening Second terminal"
   open -a Terminal "~/work/illinois-aem/" 
   echo "NPM Install"
   cd ~/work/illinois-aem/ui.apps/src/main/ && npm install && npm run build && npm run aem:watch
   echo "Finished"
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
