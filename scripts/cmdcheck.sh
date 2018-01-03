#!/bin/bash

clear

#Simple check if a cmd exists.
cmdexist() { 
	command -v "$1" >/dev/null 2>&1
}

CheckCommands(){ # Check all of the "custom" commands that we are going to need.
      printf "\n"
      printf "Checking if required commands to run this script are installed...\n\n"
	  sleep 2
      if cmdexist unzip ;then
                   	printf "$Default[$Green OK $Default] Unzip seems to be installed..\n"
					else
					printf "$Default[$Red FAIL $Default] Unzip is not installed, installing it now..\n"
					apt-get --yes install unzip
			fi
			sleep 2
	    if cmdexist dialog ;then
                   	printf "$Default[$Green OK $Default] Dialog seems to be installed..\n"
					else
					printf "$Default[$Red FAIL $Default] Dialog is not installed, installing it now..\n"
					apt-get --yes install dialog
			fi
			 sleep 2
			if cmdexist pv ;then
                   	printf "$Default[$Green OK $Default] PV seems to be installed..\n"
					else
					printf "$Default[$Red FAIL $Default] PV is not installed, installing it now..\n"
					apt-get --yes install pv
			fi
			printf "\n"
}
AreLinksAlive(){ # Check if the links that we are going to download from are alive.
     printf "Checking now if the download links are alive.\n\n"
    
	if wget $sof2ded -q --spider ;then
		printf "$Default[$Green OK $Default] sof2ded download link seems to be alive..\n"
	else	
		printf "$Default[$Yellow WARNING $Default] sof2ded link seems to be down..\n"
	fi
	sleep 2
	if wget $boelink -q --spider ;then
		printf "$Default[$Green OK $Default] [1fx] SoF2 1.00 link seems to be alive..\n"
	else	
		printf "$Default[$Yellow WARNING $Default] [1fx] SoF2 1.00 link seems to be down..\n"
	fi
	sleep 2
	if wget $caserunlink -q --spider ;then
		printf "$Default[$Green OK $Default] [CASERUN] SoF2 1.00 link seems to be alive..\n"
	else	
		printf "$Default[$Yellow WARNING $Default] [CASERUN] SoF2 1.00 link seems to be down..\n"
	fi
	sleep 2
}
