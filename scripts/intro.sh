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

intro(){
	if ! (dialog --title "Introduction" \
  --clear  \
  --msgbox "This script will attempt to auto-install 1fxmod and SoF2 1.00
on Linux.\n\nThe process is almost fully-automated.
All you have to do is select one of the options that
will be given to you.\n\nif during the process
something goes wrong,\nplease DO NOT contact BoeMan regarding the script. He is not going to bother fixing it.\n\n
Thank you for understanding." 18 54) then
		reset; 
		exit
	fi
}
