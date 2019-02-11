#!/bin/bash
#
# proxy_tor.sh - Navegação TOR
#
# Site  : linkedin.com/in/mauquinhos
# Autor : @MAUQUINHOS
#
# -----------------------------------------------------
# Este funciona da seguinte maneira, 
# baixando algumas pacote TOR e configura um
# proxy para navegação na rede .ONION
#
## Exemplo de como utilizar:
#
#   ~# ./proxy_tor.sh
#       
## Saída do script
#
#   O que deseja?
#     1: Instalar Proxy TOR"
#     2: Remover Proxy TOR"
#     e: Sair"
#
## Ao finalizar a instalação
#       Configure seu navegador para navegar com proxy, 127.0.0.1 port 8118
#
###########################################MENU
function select_menu(){
    clear
    echo "O que deseja?"
    echo "   1: Instalar Proxy TOR"
    echo "   2: Remover Proxy TOR"
    echo "   e: Sair"
    
    read -p "Selecione uma opção: " MENU
    
    case $MENU in
         1)
            add_proxy
              ;;
         2)
            del_proxy
              ;;
         e)
            clear
            exit 1
              ;;
         *)
            pause "Você fez algo errado: Press [Enter] key para continuar..."
            select_menu
            ;;
    esac
}
###########################################MENU


#####################################Instalador
#atualizar sources.list
function update(){
 wget https://www.vivaolinux.com.br/conf/download.php?codigo=1411 -O source
 sudo mv /etc/apt/sources.list /etc/apt/sources.list-bkp
 sudo mv source /etc/apt/sources.list
 sudo apt-get update && apt-get upgrade -y
}

function install_pacotes(){
tor1=$(dpkg -l | grep " tor " > /dev/null; echo $?)
tor2=$(dpkg -l | grep torsocks > /dev/null; echo $?)
tor3=$(dpkg -l | grep tor-geoipdb > /dev/null; echo $?)
tor4=$(dpkg -l | grep polipo > /dev/null; echo $?)
if [ $tor1 -eq 1 ]; then
 sudo apt-get install tor -y
#else
# pause "TOR instalado: Press [enter] key para continuar..."
fi

if [ $tor2 -eq 1 ]; then
 sudo apt-get install torsocks -y
#else
# pause "TorSocks instalado: Press [enter] key para continuar..."
fi

if [ $tor3 -eq 1 ]; then
 sudo apt-get install tor-geoipdb -y
#else
# pause "TorGeoIPDB instalado: Press [enter] key para continuar..."
fi

if [ $tor4 -eq 1 ]; then
 sudo apt-get install polipo -y
#else
# pause "Proxy instalado: Press [enter] key para continuar..."
fi
}

function config_tor(){
 sudo cp /etc/tor/torrc /etc/tor/torrc-bkp
 porta_var=$(sudo cat /etc/tor/torrc | grep "#SOCKSPort 9050 " | cut -d" " -f1,2)
 sudo sed -e "s/$porta_var/SOCKSPort 9050/g" -i /etc/tor/torrc 
# pause "TOR configurado: Press [enter] key para continuar..."
}

function config_proxy(){
 sudo cp /etc/polipo/config /etc/polipo/config-bkp
 sudo echo >  /etc/polipo/config
 sudo echo "proxyAddress = \"127.0.0.1\"" >> /etc/polipo/config
 sudo echo "proxyPort = 8118" >> /etc/polipo/config
 sudo echo "allowedClients = 127.0.0.1" >> /etc/polipo/config
 sudo echo "proxyName = \"localhost\"" >> /etc/polipo/config
 sudo echo "socksParentProxy = \"localhost:9050\"" >> /etc/polipo/config
 sudo echo "socksProxyType =socks5" >> /etc/polipo/config
 export ftp_proxy=http://localhost:8118
 export ssh_proxy=http://localhost:8118
 export https_proxy=http://localhost:8118
 export http_proxy=http://localhost:8118
 export socks_proxy=http://localhost:8118
 export socks4_proxy=http://localhost:8118
 export socks5_proxy=http://localhost:8118



# pause "Proxy configurado: Press [enter] key para continuar..."
}
#####################################Instalador


#####################################Remover
function del_proxy(){
tor1=$(dpkg -l | grep " tor " > /dev/null; echo $?)
tor2=$(dpkg -l | grep torsocks > /dev/null; echo $?)
tor3=$(dpkg -l | grep tor-geoipdb > /dev/null; echo $?)
tor4=$(dpkg -l | grep polipo > /dev/null; echo $?)
if [ $tor1 == 1 ] && [ $tor2 == 1 ] && [ $tor3 == 1 ] && [ $tor4 == 1 ]; then
 pause "Não esta instalado: Press [enter] key para continuar..."
 select_menu
fi 

stop_servicos

if [ $tor1 -eq 0 ]; then
 sudo apt-get purge tor -y
 sudo rm -R /etc/tor
# pause "TOR removido: Press [enter] key para continuar..."
fi

if [ $tor2 -eq 0 ]; then
 sudo apt-get purge torsocks -y
# pause "TorSocks removido: Press [enter] key para continuar..."
fi

if [ $tor3 -eq 0 ]; then
 sudo apt-get purge tor-geoipdb -y
# pause "TorGeoIPDB removido: Press [enter] key para continuar..."
fi

if [ $tor4 -eq 0 ]; then
 sudo apt-get purge polipo -y
 sudo rm -R /etc/polipo/
# pause "Proxy removido: Press [enter] key para continuar..."
fi
sudo apt-get -f install
sudo apt-get autoremove -y

unset ftp_proxy
unset ssh_proxy
unset https_proxy
unset http_proxy
unset socks_proxy
unset socks4_proxy
unset socks5_proxy

pause "Proxy removido: Press [enter] key para continuar..."
select_menu
}


#####################################Remover

function adv_proxy(){
 clear
 echo "Proxy configurado para as seguintes conexões"
 echo " --FTP" 
 echo " --HTTPS" 
 echo " --HTTP" 
 echo " --SOCKS" 
 echo " --SOCKS4" 
 echo " --SOCKS5"
 echo "Para utilizar SSH"
 echo "~# torify ssh USER@IP_ADDRESS -pPORT"
 read -p ""
 firefox "https://check.torproject.org/" & > /dev/null #check tor
 select_menu 
}
function start_servicos(){
 sudo /etc/init.d/tor start
 sudo /etc/init.d/polipo start
}
function stop_servicos(){
 sudo /etc/init.d/tor stop
 sudo /etc/init.d/polipo stop
}


function check_root(){
you=$(id | grep root; echo $?)
if [ $you -eq 1 ]; then
 clear
 echo "Utilize sudo ou root"
 exit 1
fi
}

function pause(){
 clear
 read -p "$*"
 clear
}


function add_proxy() {
 update
pause "Sistema atualizado: Press [enter] key para continuar..."
 install_pacotes
pause "Pacotes instalados: Press [enter] key para continuar..."
 stop_servicos
pause "Stop serviços: Press [enter] key para continuar..."
 config_tor
 config_proxy
pause "Iniciando serviços: Press [enter] key para continuar..."
 start_servicos
 clear
 echo ""
pause "Configure seu navegador para navegar com proxy, 127.0.0.1 port 8118"
 sudo rm /etc/apt/sources.list
 sudo cp /etc/apt/sources.list-bkp /etc/apt/sources.list
 adv_proxy
}
check_root
select_menu


