#!/bin/sh

# Extra programs

apt-get install git -y
apt-get install vim -y
apt-get install curl -y

# Invert script

sudo apt-get install libxcb-randr0-dev

cd
cd Documents
mkdir gits
cd gits
git clone https://github.com/zoltanp/xrandr-invert-colors.git
cd xrandr-invert-colors
sudo make deps-apt
make
sudo make install
cd

# Look

## Plank dock
sudo add-apt-repository ppa:ricotz/docky #
sudo apt-get update
sudo apt-get install plank
## plank --preferences for preferences

## Wallpaper - needs more work
cd Pictures
mkdir Wallpapers
cd Wallpapers
wget https://i.imgur.com/iX6hwvx.jpg
cd

# Sublime

add-apt-repository ppa:webupd8team/sublime-text-3
apt-get update
apt-get install sublime-text-installer -y

# Spotify

## 1. Add the Spotify repository signing key to be able to verify downloaded packages
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
## 2. Add the Spotify repository
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
## 3. Update list of available packages
sudo apt-get update
## 4. Install Spotify
sudo apt-get install spotify-client