#!/bin/bash
#
# Site  : linkedin.com/in/mauquinhos
# Autor : @MAUQUINHOS
#
# Atualize a source.list caso apresente erros
## https://help.ubuntu.com/community/Repositories/CommandLine
## http://archive.ubuntu.com/ubuntu/dists/
# Através deste link, é possível atualizar do Ubuntu Server
# Porque é o Sistema Operacional que estamos utilizando
#
#
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
#1 atualiza o sistema/
function update(){
    
    VER_ATUAL="$(date '+%y%m')"
    
    VER_SISTEMA="$(cat /etc/issue | cut -d' ' -f2 | awk -F'.' '{print $1$2}')"
    
    [ $((($VER_ATUAL-$VER_SISTEMA)/12)) -gt "12" ] && \
    
    ANO=$(date '+%Y') && \
    
    wget -O index http://archive.ubuntu.com/ubuntu/dists/  && \

    RECENTE=$(cat index | sed 's/<[^>]*>//g' | grep -vwEi "(backports|precise|security|updates|proposed|index|ubuntu|devel)" | cut -d"-" -f1,2 | grep "$ANO") && \
    
    pause "Será preciso atualizar o sistema para versões recentes: \n\t\t$RECENTE\n" && \
    
    RECENTE=$(echo $RECENTE | cut -d"/" -f1) && \
    
    SIS_ATUAL="$(lsb_release -sc)" && \
    
    CMD=' | sed "s/'$SIS_ATUAL'/'$RECENTE'/" > /etc/apt/source.list ' && \

    pause 'Utilize o comando: \n\n cp /etc/apt/source.list /etc/apt/source.list-old && cat /etc/apt/source.list-old'$CMD  && exit 0
       
    if [ $? -eq 1 ] ; then
    
        sudo apt-get  update && apt-get upgrade -y
        
        exit 1
        
    else
    
        pause "1º UPDATE e UPGRADE - instalado:  Press [Enter] key para continuar..."
    
    fi
}
#2 instala os serviços necessários
function servicos(){
    dpkg -l | grep xserver-xorg > /dev/null
    if [ $? -eq 1 ] ; then
            sudo apt-get install --no-install-recommends xserver-xorg -y
            servicos 
            exit 1
    else
            pause "2º XSERVER - instalado: Press [Enter] key para continuar..."
    fi
    dpkg -l | grep xinit > /dev/null
    if [ $? -eq 1 ] ; then
            sudo apt-get install --no-install-recommends xinit -y
            servicos 
            exit 1
    else
            pause "3º XINIT - instalado: Press [Enter] key para continuar..."
    fi
}
#3 Instala o desktop  
function select_desktop(){
    echo "Selecione o Desktop:"
    echo "   1: Ubuntu Mate Core 101MB of Memory"
    echo "   2: LXDE Core 97MB of Memory"
    echo "   3: XFCE4 107MB of Memory"
    echo "   4: PIXEL 90MB of Memory"
    echo "   e: Pular esta etapa"
    
    read -p "Digite do numero do DESKTOP: " DESKTOP
    
    case $DESKTOP in
         1)
            dpkg -l | grep mate-desktop-environment-core > /dev/null
            if [ $? -eq 1 ] ; then
                    apt-get install mate-desktop-environment-core -y
            else
                    pause "4º Ubuntu Mate - instalado."
            fi
              ;;
         2)
            dpkg -l | grep lxde-core > /dev/null
            if [ $? -eq 1 ] ; then
                    apt-get install lxde-core lxappearance -y 
            else
                    pause "4º LXDE - instalado."
            fi
              ;;
         3)
            dpkg -l | grep xfce4 > /dev/null
            if [ $? -eq 1 ] ; then
                    apt-get install xfce4 xfce4-terminal --force-yes 
            else
                    pause "4º XFCE 4 - instalado."
            fi
              ;; 
         4)
            dpkg -l | grep raspberrypi-ui-mods > /dev/null
            if [ $? -eq 1 ] ; then
                    sudo apt-get dist-upgrade
                    pause "UPGRADE NO SISTEMA: Press [Enter] key para continuar..."
                    sudo apt-get install raspberrypi-ui-mods -y
            else
                    pause "4º PIXEL RPi UI MODS - instalado"
            fi
              ;;
         e)
            exit 1
              ;;
         *)
            pause "Voce fez algo errado: Press [Enter] key para continuar..."
            select_desktop
            ;;
    esac
}
#4 Instala o Lightdm
function light_install(){
    dpkg -l | grep lightdm > /dev/null
    if [ $? -eq 1 ] ; then
            sudo apt-get install lightdm -y
            light_install 
            exit 1
    else
            pause "5º LIGHTDM - instalado: Press [Enter] key para continuar..."
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
#3 Instala o desktop    
    select_desktop
#4 Insla o LightDM
    light_install
#5 Reiniciando Sistema
    pause "6º Reiniciando: Press [Enter] key para continuar..."
    sudo apt-get clean
    service lightdm reload
    startx
    init 6

