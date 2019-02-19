#!/bin/bash
#
# Este programa serve para clonagem de HD's, Pendrive, CD'd, DVD's e etc..
#
#


read <<< "$(which dd 2> /dev/null)"

# exit if none found
[[ "$dialog" ]] || {   echo 'neither whiptail nor dialog found' >&2;   exit 1; }

# just use whichever was found
"$dialog" --msgbox "Message displayed with $dialog" 0 0
exitstatus=$?

if [ $exitstatus = 0 ]; then     

  echo "The chosen distro is:" $DISTROS; 

else
 
 echo "You chose Cancel."; 
  
fi


#DISCOS=$(lsblk -dp | grep -e "disk\|rom" | awk -F" " '{print "\""$1"\" " "\"Type: "$6"\" OFF "}' | tr '\n' ' ')
#TESTE='whiptail --title "Test Checklist Dialog" --radiolist "What is the Linux distro of your choice?" 15 60 4 '$DISCOS'3>&1 1>&2 2>&3;'
#$TESTE
