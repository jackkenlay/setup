#!/bin/bash
# Run from ReadMe File

# Append to use this bashprofile from the normal one
# If possible, install the other bits and pieces I use.


echo "Starting Setup .sh"
sudo apt update

# chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

# node
sudo apt install nodejs -y

# npm
sudo apt install npm -y

# vscode
sudo add-apt-repository ppa:ubuntu-desktop/ubuntu-make
sudo apt-get update && sudo apt-get install ubuntu-make -y
umake web visual-studio-code

# git
sudo apt install git -y

# mysql
# https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-18-04
sudo apt install mysql-server -y
sudo mysql_secure_installation


# .gitconfig
# setup ColeMak keyboard
# git autocomplete
# git prompt
# colours etc

sudo reboot
