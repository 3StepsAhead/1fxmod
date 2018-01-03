#!/bin/bash


clear

CleanUpFiles(){ #Finalize and Exit.
 printf "Cleaning up files...\n"
 
 # Remove all The Windows crap.
 rm -rf /home/SoF2/*.exe
 rm -rf /home/SoF2/*.dll
 #End
 
 #Clean up the rest from temp folder
 rm  /tmp/output.txt
 rm  /tmp/version.js
 rm  /tmp/1fxmod.tar.gz
 rm -rf /tmp/Server\ files
 rm -rf /tmp/Utility\ scripts
 rm /tmp/full.zip

 dialog --title "SUCCESS!" \
  --clear  \
  --msgbox "Congratulations!\n\nYou are ready to rock'n'roll 
with 1fx Mod on linux!\n\nHow cool is that huh?\n\nPlease 
make sure to contact BoeMan if you have any concerns
regarding 1fx Mod.\n\nEnjoy! :)\n" 18 54

clear
}
