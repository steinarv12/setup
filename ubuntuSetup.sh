#!/bin/sh

# Invert script

apt-get install xcalib
echo "alias invert='xcalib -i -a'" >> ~/.bash_aliases

# Sublime

add-apt-repository ppa:webupd8team/sublime-text-3
apt-get update
apt-get install sublime-text-installer -y
apt-get install vim -y
apt-get install curl -y

# Node and NPM
apt-get install npm -y
npm cache clean -f
npm install -g n
n stable
npm install -g bower
npm install -g grunt
# sudo ln -sf /usr/local/n/version/node/<vers>/bin/node /usr/bin/nodejs

# Python related
apt-get install pip -y
apt-get install pip3 -y
