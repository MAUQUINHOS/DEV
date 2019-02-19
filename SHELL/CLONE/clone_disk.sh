#!/bin/bash
#
# Este programa serve para clonagem de HD's, Pendrive, CD'd, DVD's e etc..
# ./clone_disk.sh #Clona dicos com terminal
#
#
#
# Check usuario root
ID=$(id | grep "root")
[[ "$ID" ]] || { clear; echo 'Você não é root, e não consegue executar!' >&2; exit 1; }
#
# Verifica se contém programas necessários para execução do código
read programas <<< "$(which dd 2> /dev/null)"
#
# Condição do de veirificação de programas
[[ "$programas" ]] || {   echo 'neither whiptail nor dialog found' >&2;   exit 1; }
#
#
LISTAR_DISCOS(){
  # Lista todos os discos disponiveis na computador
  DISCOS=$(lsblk -dp | grep -e "disk\|rom" | awk -F" " '{print "\""$1"\" " "\"Type: "$6"\" OFF "}' | tr '\n' ' ')

  # Cria a msgbox listando os disco encontrados armazenados em $DISCOS
  TESTE='whiptail --title "Discos" --radiolist "Qual disco você que copiar?" 15 60 4 '$DISCOS' 3>&1 1>&2 2>&3;'

  # O eval executa a função contida na variavel $TESTE e armazena seu resultado em $DISCOS
  DISCOS=$(eval "$TESTE") 
}


echo "Please enter your name: \c"
read OPT
[ -n "$newname" ] && OPT=$newname


case OPT in
  1) LISTAR_DISCOS; echo $DISCOS ;; #Se foi informado a opção 1 então realiza o echo, no caso o parâmetro é numero

  2) echo "2" ;; # Podendo ser texto
  *) echo "Opcao Invalida!" ;; # Algo que não se enquadre acima

esac


#comandos para clonar
#dd if=/dev/sda bs=4M | gzip -c | split -b 2G - /mnt/backup_sda.img.gz

#cat /mnt/UDISK1T/backup_sda.img.gz.* | gzip -dc | dd of=/dev/sda bs=4M



