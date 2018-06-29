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

kill-all(){
# Needs researching
  echo "Killing all"
  kill -9 -1
}

kill-jars(){
  echo "Killing all Java Processes"
  pkill -f 'java -jar'
}

setup-camelot(){

  # useful info:
  #  https://www.macobserver.com/tmo/article/how-to-launch-os-x-apps-from-the-command-line

   ## close all windows/process
   echo "Setting up Camelot"
   kill-jars
   killall node
   echo "Opening JAR"
   open -g -a Finder ~/AEM/camelot_il_aem/cq-quickstart-p4502.jar 
   #open -a /System/Library/CoreServices/Jar\ Launcher.app/ ~/AEM/camelot_il_aem/cq-quickstart-p4502.jar 
  #  java -jar ~/AEM/camelot_il_aem/cq-quickstart-p4502.jar
   echo "Opening Notes"
   open -g -a /Applications/Notes.app/
   echo "Opening Mail"
   open -g -a /Applications/Mail.app/
   echo "Opening Slack"
   open -g -a /Applications/Slack.app/
  #  echo "Opening Spotify"
  #  open -g -a /Applications/Spotify.app/
   echo "Opening Skype"
   open -g -a /Applications/Skype.app/
   echo "Opening Chrome"
   open -g -a /Applications/Google\ Chrome.app/
  #  echo "Waiting for Jar to finish booting up"
  #  sleep 30
   echo "Opening IJ"
   cd ~/work/illinois-aem/
   ll
   open -g -a /Applications/IntelliJ\ IDEA.app .
  #  echo "Opening finder at AEM location"
  #  open  -a Finder ~/AEM/camelot_il_aem/
  #  echo "Npm Install"
  #  cd ~/work/illinois-aem/ui.apps/src/main/ && npm install && npm run build && cd ~/work/illinois-aem/ && ll
  #  echo "Maven Install"
  #  mvn clean install -PautoInstallPackage
   #open second terminal

  echo "Waiting 120 seconds before npm install etc"
  sleep 120

  #  echo "Opening Second terminal"
  #  open -g -a Terminal ~/work/illinois-aem/cd ui.apps/src/main/
  #  open -a Terminal ~/work/illinois-aem/ui.apps/src/main/ --args 'll'

  # this works
  # osascript -e 'tell application "Terminal" to do script "ll;ll"'

  # echo "NPM Install"
  # cd ~/work/illinois-aem/ui.apps/src/main/ && npm install && npm run build && npm run aem:watch
  echo "maven install"
  mvn clean install -PautoInstallPackage

  killall node
  echo "Opening Second window for Excalibur"
  osascript -e 'tell application "Terminal" to do script "cd ~/work/illinois-aem/excalibur-mock; mvn clean install -Prun-excalibur-mock"'

  echo "Waiting 30 seconds for Excalibur"
  sleep 30

  echo "Opening Third for npm install"
  osascript -e 'tell application "Terminal" to do script "cd ~/work/illinois-aem/ui.apps/src/main; npm run build && npm run aem:watch"'
  # open -g -a Terminal ~/work/illinois-aem/

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

M3_HOME=/usr/local/bin/apache-maven-3.5.2
export M3_HOME

PATH=$PATH:$HOME/.local/bin:$HOME/bin:$JAVA_HOME/bin:$M3_HOME/bin
export PATH


#Java
#http://davidcai.github.io/blog/posts/install-multiple-jdk-on-mac/
# Init jenv
if which jenv > /dev/null; then eval "$(jenv init -)"; fi
export JAVA_HOME=$(/usr/libexec/java_home)


