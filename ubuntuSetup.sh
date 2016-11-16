#!/bin/bash

# Function declarations

function baseline {
	# Extra programs

	printf "Installing git..."
	apt-get -qq install git -y
	printf "Installing vim..."
	apt-get -qq install vim -y
	printf "Installing curl..."
	apt-get -qq install curl -y

	# Chrome
	printf "Setting up Chrome..."
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
	sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
	apt-get -qq update -y
	apt-get -qq install google-chrome-stable 

	# Invert script
	printf "Setting up 'invert'"
	apt-get -qq install libxcb-randr0-dev -y
	cd
	cd Documents
	mkdir gits
	cd gits
	git clone https://github.com/zoltanp/xrandr-invert-colors.git
	cd xrandr-invert-colors
	make deps-apt
	make
	make install
	cd

	# Spotify
	printf "Setting up Spotify..."
	## 1. Add the Spotify repository signing key to be able to verify downloaded packages
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
	## 2. Add the Spotify repository
	echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
	## 3. Update list of available packages
	apt-get -qq update -y
	## 4. Install Spotify
	apt-get -qq install spotify-client

	printf "Cosmetic work"
	printf "Installing plank..."

	## Plank dock
	add-apt-repository ppa:ricotz/docky #
	apt-get -qq update -y
	apt-get -qq install plank -y
	## plank --preferences for preferences

	printf "Getting a wallpaper"
	## Wallpaper - needs more work
	cd Pictures
	mkdir Wallpapers
	cd Wallpapers
	wget $WALLPAPER https://i.imgur.com/iX6hwvx.jpg
	cd

}

function basic {

}


function work {
	# Sublime
	printf "Setting up Sublime..."
	add-apt-repository ppa:webupd8team/sublime-text-3
	apt-get -qq update -y
	apt-get -qq install sublime-text-installer -y
}

# Begin

cat << "EOF"
 _____      _               
/  ___|    | |              
\ `--.  ___| |_ _   _ _ __  
 `--. \/ _ | __| | | | '_ \ 
/\__/ |  __| |_| |_| | |_) |
\____/ \___|\__|\__,_| .__/ 
                     | |    
                     |_|    

EOF

printf "First this script will install few things that will be in any setup including Spotify, Chrome, git and more."

read -p "Are you sure you want to continue? (Y/N)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Nn]$ ]]
then
    exit
fi

printf "Starting setup"
printf "-----------------"

baseline

printf "Please choose the purpase of this machine."

OPTIONS="Work Basic Games"
select opt in $OPTIONS; do
   if [ "$opt" = "Work" ]; then
   	printf "'Work' selected, starting setup..."
   	WALLPAPER="https://i.imgur.com/iX6hwvx.jpg"
    work
    exit
   elif [ "$opt" = "Basic" ]; then
   	printf "'Basic' selected, starting setup..."
   	WALLPAPER="https://i.imgur.com/iX6hwvx.jpg"
    basic
    exit
   elif [ "$opt" = "Games" ]; then
   	printf "'Games' selected, starting setup..."
    echo Option not ready
    exit
   else
    clear
    echo Option not available
   fi
done
