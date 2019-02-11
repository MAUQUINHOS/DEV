#!/bin/bash
###############################################
#Save file to: script-desktop.sh
#1- wget -O script-desktop.sh linkdoarquinho.sh
#2- chmod +x script-desktop.sh
#3- sudo -s
#4- ./script-desktop.sh
#1. Display Server -Xorg Display Server
#2. Desktop Environment - Pi Improved Xwindows Environment Lightweight (PIXEL) or Lightweight X11 Desktop Environment (LXDE) or XFCE Desktop Environment (XFCE) or MATE Desktop Environment (MATE)
#3. Window Manager - Openbox Window Manager (PIXEL/LXDE) or XFWM Window Manager (XFCE) or Marco Window Manager (MATE)
#4. Login Manager - LightDM Login Manager
###############################################
#############################  @mauquinhos   ##
# mais informações ~> https://www.raspberrypi.org/forums/viewtopic.php?f=66&t=133691 25/02/2017
###############################################
#1 atualiza o sistema/
function update(){
    sudo apt-get  update && apt-get upgrade -y
    pause "1º UPDATE e UPGRADE - instalado:  Press [Enter] key para continuar..."
}


#2 instala os serviços necessários
function servicos(){
    dpkg -l | grep apache2 > /dev/null
    if [ $? -eq 1 ] ; then
            sudo apt-get install apache2 -y
            servicos 
            exit 1
    else
            systemctl restart apache2
            pause "2º Apache2 - instalado: Press [Enter] key para continuar..."
    fi
    dpkg -l | grep php5 > /dev/null
    if [ $? -eq 1 ] ; then
            sudo apt-get install php5 libapache2-mod-php5 -y
            servicos 
            exit 1
    else
            systemctl restart apache2
            pause "3º PHP5 libapache2 - instalado: Press [Enter] key para continuar..."
    fi
    
    dpkg -l | grep mysql-server > /dev/null
    if [ $? -eq 1 ] ; then
            sudo apt-get install mysql-server php5-mysql -y
            servicos 
            exit 1
    else
            systemctl restart apache2
            pause "4º MYSQL-SERVER - instalado: Press [Enter] key para continuar..."
    fi
    
    dpkg -l | grep phpmyadmin > /dev/null
    if [ $? -eq 1 ] ; then
            sudo apt-get install phpmyadmin -y
            echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf 
            servicos 
            exit 1
    else
            systemctl restart apache2
            pause "5º PHPMYADMIN - instalado: Press [Enter] key para continuar..."
    fi
    
    
}

#5 Pause
function pause(){
    clear
    read -p "$*"
    clear
}
#1 Update
    update
#2 Instala servico
    servicos
#3 Reiniciando Sistema
    pause "6º Reiniciando: Press [Enter] key para continuar..."
    sudo apt-get clean
    hostname -I

