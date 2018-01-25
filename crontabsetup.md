# Reminder every 60 minutes for a popup

## Prereq
brew install terminal-notifier
or
gem install terminal-notifier

## Cronsetup
crontab -e

### press I to enter VIM's insert mode
* * * * * /usr/local/bin/terminal-notifier -message "Commit -60" -title "Commit"

### press esc then ZZ (ensure its capitals)
### Confirmation
The script should now run every 60 seconds (as a test)
crontab -l

To change to every 45 minutes, and then dissappear, simply have:

0/45 * * * * /usr/local/bin/terminal-notifier -title "45" -message "45" -timeout 2

Sources:
https://stackoverflow.com/questions/5588064/how-do-i-make-a-mac-terminal-pop-up-alert-applescript (3rd entry)
http://www.java-samples.com/showtutorial.php?tutorialid=1420
https://crontab.guru/#*_*_*_*_*
https://stackoverflow.com/questions/28856326/crontab-simple-echo-not-running
https://github.com/julienXX/terminal-notifier
