#!/bin/bash


#Small function so we don't have to repeat the code all the time.
#This way we also keep it more eye-friendly.
ProcessDownloads(){
 local website="$1" text="$2" 
 wget -P /tmp "$website" 2>&1 | \
 stdbuf -o0 awk '/[.] +[0-9][0-9]?[0-9]?%/ { print substr($0,63,3) }' | \
 dialog --title "Please Wait" --gauge "$text" 10 100 

}

ProcessFiles(){ 
#Let them pick from what website they want to download.
SOF2LINKS=(1 "1fx.uk.to" 2 "caserun.com" ) 
caserun=false
boe=false

SELECT=$(dialog --clear \
                --title "SoF2 1.00 Download" \
                --menu "Please Select one of the following links to begin downloading: " \
                15 40 4 \
                "${SOF2LINKS[@]}"\
                2>&1 >/dev/tty)
 clear 

 case $SELECT in  
  1)
   boe=true ;; # 1fx.uk.to
  2)
   caserun=true ;; # caserun.com

  esac  
  
  #Download sof2ded first before doing anything else.
  #ProcessDownloads "$sof2ded" "Downloading [sof2ded] from 1fx. Website."
  # -- no longer needed pff BOOBMAN :(!!! 
  
  #SoF2 Download Stuff.
  if $caserun == true ; then
     ProcessDownloads "$caserunlink" "Downloading [SoF2 1.00] from caserun Website" 
  elif $boe == true ; then
	 ProcessDownloads "$boelink" "Downloading [SoF2 1.00] from 1fx. Website" 
	fi
	clear
	
    #Extract SoF2 into the /home/ Directory.
	if $caserun == true ; then
       unzip /tmp/full.zip -d /home/SoF2
    elif $boe == true ; then
	   mv /tmp/SoF2\ -\ 1.00.zip /tmp/full.zip
       unzip /tmp/full.zip -d /home/SoF2
    fi
}
ProcessMod(){

 #Download the latest 1fx mod Version. This will automatically download the latest version of 1fx Mod.
 #Please note -- The link should work as long as boeman doesn't rename the 1fx Mod file.
 #Currently it's like 1fx.(space)Mod(space)Version(dash)OS(space)gameversion(parentheses)(file suffix)
 #I'm not going to try and find the best solution for this. If such thing ever happens, you can manually
 #update the link.
 
 wget -P /tmp "http://1fxmod.org/download/version.js"
 clear
 
 #Get the 1fx Mod version text shizzle. Make sure it only grabs the first match
 cat /tmp/version.js | grep -oh -m 1 "\w*1fx. Mod ...\w*" > /tmp/output.txt
 
 #Now Fetch the actual Version.
 LINE=$(cat /tmp/output.txt | grep -o -E '[., 0-9]+')
 Array=($(awk -F: '{$1=$1} 1' <<<"${LINE}"))
 echo ${Array[2]} > /tmp/output.txt 
 
 #Begin Downloading the Mod.
 GrabVersion="${Array[2]}"
 ProcessDownloads "1fxmod.org/download/files/1fx.%20Mod ${Array[2]}-linux%20(v1.00).tar.gz" "Downloading 1fx. Mod. Version: $GrabVersion"
 clear
 
 #Rename the long file name to just "1fxmod" it's easier to handle. 
 mv /tmp/1fx.\ Mod\ $GrabVersion-linux\ \(v1.00\).tar.gz /tmp/1fxmod.tar.gz
 
 #Extract 1fx Mod to the sof2 directory.
 (pv -n /tmp/1fxmod.tar.gz | tar xzf - -C /tmp/ ) 2>&1 | dialog --title "Please wait" --gauge "Extracting 1fx mod file.." 10 100
  
  #Move to SoF2 Directory.
  mv /tmp/Server\ files/1fx /home/SoF2/
  mv /tmp/Server\ files/sof2ded /home/SoF2/ 
  chmod +x /home/SoF2/sof2ded #Executable Permission.
  
}

#An extra step is required here, due to the new chat system from boe.
#ask the user if they want to include the classic RPM sounds.

function ProcessSounds(){
  
SOUNDSYSTEM=(1 "RPM+MVCHAT" 2 "MVCHAT" ) 
extended=false
mvchat=false

Option=$(dialog --clear \
                --title "[1fx] Sounds" \
                --menu "Please select one of the following options:\n\n [RPM+MVCHAT] => Classic RPM Sounds + Extended Sounds
                \n [MVCHAT] => Extended Sounds only\n " \
                25 50 4 \
                "${SOUNDSYSTEM[@]}"\
               2>&1 >/dev/tty)

    clear

case $Option in  
  1)
   extended=true ;; 
  2)
   mvchat=true ;; 

  esac

  if $extended == true ; then
     mv /tmp/Optional\ files/RPM\ soundpack/rpm\ +\ extended.mvchat /home/SoF2/1fx/files/mvchats/
     rm /home/SoF2/1fx/files/mvchats/extended.mvchat 
     rm -rf /tmp/Optional\ files
  elif $mvchat == true ; then
	   rm -rf /tmp/Optional\ files
	fi

   clear
}