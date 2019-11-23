#!/bin/bash
#
## Adicionando/Confirmando arquitetura de 32 bits ##
sudo dpkg --add-architecture i386
#
## Repositorios ##
sudo apt-get install software-properties-common python-software-properties -y
sudo add-apt-repository ppa:oguzhaninan/stacer -y
#
## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock
#
#Atualizando sistema
sudo  apt-get update
sudo  apt-get upgrade
#
## Diretorios temas ##
mkdir -p ~/.temp0/
mkdir -p ~/.themes/
mkdir -p ~/.icons/
#
#
programas=(
build-essential
libssl-dev
libdvd-pkg
ubuntu-restricted-extras
zram-config
numlockx
gdm3
cinnamon
dconf-editor
network-manager
ttf-mscorefonts-installer
cups
cups-ipp-utils
cups-daemon
system-config-printer
system-config-printer-common
system-config-printer-gnome
system-config-printer-udev
gnome-software
gnome-tweaks
gnome-software-plugin-flatpak
python3
python-pip
gthumb
bleachbit
mate-calc
gedit
gimp
flatpak
stacer
wine-stable
winetricks
playonlinux
)
#
## Loop Instalando Programas ##
function check_dependencias() {
 sudo dpkg -l $1 2>&- | grep $1 > /dev/null 2>&1
 [[ $? == 1 ]] && { sudo apt-get install $soft -y; echo "[ $i ] instalado. Pressione uma tecla para continuar... } 
}
#
## Le a lista de programas
for soft in ${programas[@]}; do 
 check_dependencias "$soft"
done
#
## Remove repositorios ##
sudo add-apt-repository ppa:oguzhaninan/stacer -r -y
#
## Gerenciador de Redes ##
sudo head -n4 /etc/netplan/01-netcfg.yaml > ~/01-network-manager-all.yaml
sudo echo "  renderer: NetworkManager" >> ~/01-network-manager-all.yaml
sudo mv ~/01-network-manager-all.yaml /etc/netplan/01-network-manager-all.yaml
#read -p "Gerenciador de rede instalado e configurado"
#
## Temas ##
#unzip win-tema.zip -d ~/.temp0/
#mv ~/.temp0/* ~/.themes/
## Icones ##
unzip win-icones.zip -d ~/.temp0/
## Cursores ##
unzip win-cursor.zip -d ~/.temp0/
mv ~/.temp0/* ~/.icons/
#
## Pacotes adicionais ##
#sudo /etc/init.d/cups start
sudo snap install wps-office-multilang &&
sudo dpkg-reconfigure libdvd-pkg
wget -O google-chome64.deb   https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chome64.deb
wget https://code-industry.net/public/master-pdf-editor-5.4.38-qt5.amd64.deb -O master-pdf-editor.deb
sudo dpkg -i master-pdf-editor.deb
sudo apt-get -f install
#
#
## AFTER INSTALL ##
## Desktop Imagem ##
#Removendo Desktop Ubuntu
sudo echo -e '#!/bin/bash
sudo apt-get remove ubuntu-session ubuntu-minimal
sudo apt-get purge ubuntu-session ubuntu-minimal
sudo apt-get autoremove
sudo rm -R /usr/share/backgrounds/* \n
sudo cp desktop.png /usr/share/backgrounds/warty-final-ubuntu.png \n
#sudo cp ~/.themes/Windows-10-3.0/cinnamon/menu.png /usr/share/cinnamon/theme/menu-symbolic.png \n
sudo gsettings  set org.cinnamon.desktop.background picture-uri "file:///usr/share/backgrounds/warty-final-ubuntu.png" \n
sudo gsettings set org.nemo.desktop computer-icon-visible true \n
sudo gsettings set org.nemo.desktop home-icon-visible true \n
sudo gsettings set org.nemo.desktop trash-icon-visible true \n
sudo gsettings set org.gnome.settings-daemon.peripherals.keyboard numlock-state 'on' \n
cp Google*.desktop ~/Área\ de\ Trabalho/ \n
chmod 755 Google*' > ~/.temp0/after_install.sh
sudo cp desktop.png ~/.temp0/desktop.png 
cp Google*.desktop ~/.temp0/
chmod 755 ~/.temp0/Google*
sudo chmod +x ~/.temp0/after_install.sh
sudo mv ~/.temp0/after_install.sh ~/
#
#ALTERAR LOGO
#sudo cp logo.png /usr/share/plymouth/ubuntu-logo.png
#sudo cp logo.png /usr/share/plymouth/themes/ubuntu-logo.png
#sudo update-initramfs -u
#
## Removendo Temp ##
#sudo rm -R ~/.temp0/
sudo apt autoremove

