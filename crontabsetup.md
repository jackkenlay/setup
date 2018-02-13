# Popup every 45 minutes

## Prereq
```brew install terminal-notifier```
or
```gem install terminal-notifier```

## Cronsetup
```crontab -e```

## To change to every 45 minutes add the following line:
```0/45 * * * * /usr/local/bin/terminal-notifier -title "45" -message "45" -timeout 2```

## Verification:
```crontab -l```

### Sources:
https://stackoverflow.com/questions/5588064/how-do-i-make-a-mac-terminal-pop-up-alert-applescript (3rd entry)
http://www.java-samples.com/showtutorial.php?tutorialid=1420
https://crontab.guru/#*_*_*_*_*
https://stackoverflow.com/questions/28856326/crontab-simple-echo-not-running
https://github.com/julienXX/terminal-notifier
