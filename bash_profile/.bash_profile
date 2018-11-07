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


bring-terminal-to-front(){
  osascript -e 'tell application "Terminal" to activate'
  organise-terminal-windows
}

mount-london-nas(){
  mkdir -p ~/LondonNAS && mount -t smbfs //admin:password@192.168.1.191/Users/jackk ~/LondonNAS/;
  echo "Done";
}

setup-cmat(){
  # Note the directory doesnt have forward slashes at beggining or end.
  aemdirectory=~/"AEM/cmat6.3"
  repodirectory=~/"work/adobe-customer-maturity-assessment"
  aemfilename="cq-quickstart-p4502.jar"
  mvncleaninstalldirectory=~/"work/adobe-customer-maturity-assessment/ADCMA"
  
  echo "Setting up CMAT"
  echo "Killing IntelliJ"
  pkill -f "IntelliJ"

  kill-jars
  killall node

  echo "killing all chromes"
  pkill chrome

  countdown "00:00:10"

  echo "Opening Logs"
  osascript -e 'tell application "Terminal" to do script "tail -f '"$aemdirectory"'/crx-quickstart/logs/error.log"'

  echo "Opening JAR"
  osascript -e 'tell application "Terminal" to do script "cd '"$aemdirectory"'; java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=30303 -jar '$aemfilename'" '
  
  open-normal-apps
  bring-terminal-to-front
  organise-terminal-windows

  echo "Opening IJ"
  cd ''"$repodirectory"''
  open -g -a /Applications/IntelliJ\ IDEA.app .

  wait-and-bring-terminals-to-front  

  cd ''"$mvncleaninstalldirectory"''
  echo "maven install"
  mvn clean install -PautoInstallPackage ||  mvn clean install -PautoInstallPackage

  echo "Starting AEM Sync"
  osascript -e 'tell application "Terminal" to do script "cd '"$mvncleaninstalldirectory"'; aemsync"'
  
  bring-terminal-to-front
  echo "Setup CMAT finished"
}

wait-and-bring-terminals-to-front(){
  bring-terminal-to-front
  echo "Waiting 120 seconds before mvn clean install"
  countdown "00:00:10"
  bring-terminal-to-front
  countdown "00:00:10"
  bring-terminal-to-front
  countdown "00:00:10"
  bring-terminal-to-front
  countdown "00:00:10"
  bring-terminal-to-front
  countdown "00:00:10"
  bring-terminal-to-front
  countdown "00:00:10"
  bring-terminal-to-front
  countdown "00:01:00"
  bring-terminal-to-front
}

setup-scc(){
  echo "Setting up Sheffield County Council"

  echo "Killing IntelliJ"
  pkill -f "IntelliJ"

  kill-jars
  killall node

  echo "killing all chromes"
  pkill chrome

  sleep 10

  echo "Opening JAR"  
  osascript -e 'tell application "Terminal" to do script "cd ~/AEM/scc-aem-6.2/; java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=30303 -jar cq-quickstart-6.2.0.jar" '

  echo "Opening Logs"
  osascript -e 'tell application "Terminal" to do script "tail -f ~/AEM/scc-aem-6.2/crx-quickstart/logs/error.log"'
  
  organise-terminal-windows
  
  open-normal-apps

  echo "Waiting 120 seconds before mvn clean install"
  sleep 120

  cd ~/work/scc/Site
  echo "maven install"
  mvn clean install -PautoInstallPackage
  
  echo "Opening IJ"
  cd ~/work/scc/
  open -g -a /Applications/IntelliJ\ IDEA.app .

  echo "Finished"
}

open-normal-apps(){
  echo "Opening Rocket Chat"
  open -g -a /Applications/Rocket.Chat+.app/
  echo "Opening Notes"
  open -g -a /Applications/Notes.app/
  echo "Opening Mail"
  open -g -a /Applications/Mail.app/
  echo "Opening Chrome"
  open -g -a /Applications/Google\ Chrome.app/
  echo "Opening Skype"
  open -g -a /Applications/Skype.app/
}

organise-terminal-windows() {
  # todo
  # https://mac.appstorm.net/general/build-a-window-management-app-with-apptivate-and-applescript/
  osascript -e 'tell application "System Events" to tell process "Terminal"
    tell window 1
        set size to {700, 440}
        set position to {0, 0}
    end tell
    tell window 2
        set size to {700, 440}
        set position to {700, 0}
    end tell
    tell window 3
        set size to {700, 440}
        set position to {0, 460}
    end tell
    tell window 4
        set size to {700, 440}
        set position to {700, 460}
    end tell
end tell'  
}

# Old - for reference only
# organise-terminal-windows() {
#   osascript -e 'tell application "System Events" to tell process "Terminal"
#     tell window 1
#         set size to {1150, 850}
#         set position to {50, 50}
#     end tell
# end tell'  
# }


setup-hw(){
  # useful info:
  # https://www.macobserver.com/tmo/article/how-to-launch-os-x-apps-from-the-command-line

   ## close all windows/process
   echo "Setting up Heath Wallace"

   echo "Killing IntelliJ"
   pkill -f "IntelliJ" 

   kill-jars
   killall node

   echo "killing all chromes"
   pkill chrome

   sleep 10

   echo "Opening JAR"
   open -g -a Finder ~/AEM/aem.6.2/cq-quickstart-6.2.0.jar

   echo "Opening Notes"
   open -g -a /Applications/Notes.app/
   echo "Opening Mail"
   open -g -a /Applications/Mail.app/

   echo "Opening Chrome"
   open -g -a /Applications/Google\ Chrome.app/

   echo "Opening IJ"
   cd ~/work/ui-centre/
      open -g -a /Applications/IntelliJ\ IDEA.app .

  echo "Waiting 120 seconds before mvn clean install"
  sleep 120

  echo "maven install"
  mvn clean install -PautoInstallPackage

  killall node

  osascript -e 'tell application "Terminal" to do script "cd ~/work/ui-centre/; gulp dev"'
 
  # go to the npm folder (javascript) and run npm start
  # echo "Waiting 30 seconds"
  # sleep 30
  # echo "Opening Third for npm install"
  # osascript -e 'tell application "Terminal" to do script "cd ~/work/ui-centre/; npm run build && npm run aem:watch"'

  echo "Finished"
}




setup-ill(){

   echo "Killing IntelliJ"
   pkill -f "IntelliJ" 
     echo "killing all chromes"
   pkill chrome
  # useful info:
  #  https://www.macobserver.com/tmo/article/how-to-launch-os-x-apps-from-the-command-line

   ## close all windows/process
   echo "Setting up ILL"
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
  gulp install

  killall node
  echo "Opening Second window for Excalibur"
  osascript -e 'tell application "Terminal" to do script "cd ~/work/illinois-aem/excalibur-mock; mvn clean install -Prun-excalibur-mock"'

  # go to the npm folder (javascript) and run npm start
  echo "Waiting 30 seconds for Excalibur"
  sleep 30

  echo "Opening Third for npm install"
  osascript -e 'tell application "Terminal" to do script "cd ~/work/illinois-aem/ui.apps/src/main; npm run build && npm run aem:watch"'
  # open -g -a Terminal ~/work/illinois-aem/

  echo "Finished"
}




setup-pli(){

  # useful info:
  #  https://www.macobserver.com/tmo/article/how-to-launch-os-x-apps-from-the-command-line

   ## close all windows/process
   echo "Setting up PLI"

   echo "Killing IntelliJ"
   pkill -f "IntelliJ" 

   kill-jars
   killall node

   echo "killing all chromes"
   pkill chrome

   sleep 10

   echo "Opening JAR"
   open -g -a Finder ~/AEM/pli/cq-quickstart-p4502.jar 

   echo "Opening Notes"
   open -g -a /Applications/Notes.app/
   echo "Opening Mail"
   open -g -a /Applications/Mail.app/
   echo "Opening Slack"
   open -g -a /Applications/Slack.app/

   echo "Opening Chrome"
   open -g -a /Applications/Google\ Chrome.app/

   echo "Opening IJ"
   cd ~/work/ctp-lottery-ie-aem/
   ll
   open -g -a /Applications/IntelliJ\ IDEA.app .

  echo "Waiting 120 seconds before npm install etc"
  sleep 120

  echo "maven install"
  mvn clean install -PautoInstallPackage

  killall node
 
  # go to the npm folder (javascript) and run npm start
  echo "Waiting 30 seconds"
  sleep 30
  echo "Opening Third for npm install"
  osascript -e 'tell application "Terminal" to do script "cd ~/work/ctp-lottery-ie-aem/ui.apps/src/main; npm run build && npm run aem:watch"'

  echo "Finished"
}

countdown()
(
  IFS=:
  set -- $*
  secs=$(( ${1#0} * 3600 + ${2#0} * 60 + ${3#0} ))
  while [ $secs -gt 0 ]
  do
    sleep 1 &
    printf "\r%02d:%02d:%02d" $((secs/3600)) $(( (secs/60)%60)) $((secs%60))
    secs=$(( $secs - 1 ))
    wait
  done
  echo
)
