#!/bin/bash

################################################################################
# Date:     2018/01/03
# Author:   Shoke (admin@instservers.com)
# Web:      http://roxmod.net
#
# Program:
#   Automatic installation of 1fx Mod on Linux. 
#
# History:
#   2018/01/03 first release
#   
#   
#   Script was made for total linux newbies, that just simply want to install and
#   run SoF2 Servers with 1fx Mod. You're free to modify the script as you wish.
#   
################################################################################

clear

if [ "$(id -u)" -ne "0" ] ; then
    echo "This script must be executed with root privileges"
    exit #killme
fi

init(){ # Initialization 
   directory="scripts"
 	for file in $(ls "$directory") ; do
		source "$directory"/"$file"
	done  
}
# Begin Stufff.
main(){
    CheckCommands  # Check if stuff is installed before actually starting the script.
	AreLinksAlive  # Check if website links are alive
	intro          # introduction
	ProcessFiles   # SoF2  
	ProcessMod     # 1fx Mod
	CleanUpFiles   # File Clean up
}

init
main
