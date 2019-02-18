#!/bin/bash
###############################################
# Este script foi instalado e homologado em um RasbpBerry PI
# Save file to: script-desktop.sh
#1- wget -O instalador_lamp.sh linkdoarquinho.sh
#2- chmod +x instalador_lamp.sh
#3- sudo -s
#4- ./instalador_lamp.sh
#1. Checa se o sistema estaatualizado
#2. Verifica se os serviços estão instalados
#3. Instala os serviços
###############################################
#############################  @mauquinhos   ##

#1 atualiza o sistema
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

