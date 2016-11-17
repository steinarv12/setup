#!/bin/bash

# Function declarations

function baseline {
	# Extra programs

	printf "Installing git...\n"
	apt-get -qq install git -y
	printf "Installing vim...\n"
	apt-get -qq install vim -y
	printf "Installing curl...\n"
	apt-get -qq install curl -y

	# Chrome
	printf "Setting up Chrome...\n"
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
	sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
	apt-get -qq update -y
	apt-get -qq install google-chrome-stable 

	# Invert script
	printf "Setting up 'invert'\n"
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
	printf "Setting up Spotify...\n"
	## 1. Add the Spotify repository signing key to be able to verify downloaded packages
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
	## 2. Add the Spotify repository
	echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
	## 3. Update list of available packages
	apt-get -qq update -y
	## 4. Install Spotify
	apt-get -qq install spotify-client

	# Conky
	apt-get -qq install conky -y

	printf "Copying conky script..."
	echo $CONKYSCRIPT
	cp $CONKYSCRIPT /etc/conky/conky.conf

	printf "Cosmetic work\n"
	printf "Installing plank...\n"

	## Plank dock
	add-apt-repository ppa:ricotz/docky #
	apt-get -qq update -y
	apt-get -qq install plank -y
	## plank --preferences for preferences

	printf "Getting a wallpaper\n"
	## Wallpaper - needs more work
	mkdir ~/Pictures/Wallpapers
	cp $WALLPAPER ~/Pictures/Wallpapers

	clonky
	plank --preferences

}

function basic {
	printf "All done!\n"
}

function game {
	apt-get -qq install steam -y
	apt-get -qq install lm-sensors -y
	cd $DIRE
}

function work {
	# Sublime
	printf "Setting up Sublime...\n"
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

printf "Starting setup\n"
printf "-----------------\n"

baseline

printf "Please choose the purpase of this machine.\n"

DIRE=$(pwd)
OPTIONS="Work Basic Games"
select opt in $OPTIONS; do
   if [ "$opt" = "Work" ]; then
   	printf "'Work' selected, starting setup...\n"
   	WALLPAPER=$DIRE/wallpaper.jpg
   	CONKYSCRIPT=$DIRE/conky.conf_work
    work
    exit
   elif [ "$opt" = "Basic" ]; then
   	printf "'Basic' selected, starting setup...\n"
   	WALLPAPER=$DIRE/iX6hwvx.jpg
   	CONKYSCRIPT=$DIRE/conky.conf_base
    basic
    exit
   elif [ "$opt" = "Games" ]; then
   	printf "'Games' selected, starting setup...\n"
   	WALLPAPER=$DIRE/Gaming-Wallpapers-Images-Hd.jpg
   	CONKYSCRIPT=$DIRE/conky.conf_game
    game
    exit
   else
    clear
    echo Option not available
   fi
done

printf "Setup is complete.\n"
printf "What is needed to do manually:\n"
printf "Set the wallpaper\n"
printf "Edit Plank settings\n"
printf "Autostart plank and conky\n"
