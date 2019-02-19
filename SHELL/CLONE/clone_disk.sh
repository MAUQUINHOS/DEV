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
SELECIONAR_DISCOS(){
  # Lista todos os discos disponiveis na computador
  DISCOS=$(lsblk -dp | grep -e "disk\|rom" | awk -F" " '{print "\""$1"\" " "\"Type: "$6"\" OFF "}' | tr '\n' ' ')

  # Cria a msgbox listando os disco encontrados armazenados em $DISCOS
  TESTE='whiptail --title "Discos" --radiolist "Qual disco você que copiar?" 15 60 4 '$DISCOS' 3>&1 1>&2 2>&3;'

  # O eval executa a função contida na variavel $TESTE e armazena seu resultado em $DISCOS
  DISCOS=$(eval "$TESTE")  
 
}

LISTAR_DISCOS(){
  # Lista todos os discos disponiveis na computador
  dsk=$(lsblk -dp | grep -e "disk\|rom" | awk -F" " '{print $1 " TIPO:" $6 " TAMANHO:" $4}' | sort -u)
   
  #Exibe os discos disponíveis
  whiptail --title "Discos disponíveis" --msgbox "DISCOS:\n$dsk" 15 78
 
}

PS3='Escolha uma opção: '
options=("Selecionar Disco" "Listar discos" "Option 3" "Quit")
select opt in "${options[@]}"
do  
    case $opt in
        "Selecionar Disco")
            SELECIONAR_DISCOS
            echo $DISCOS
            ;;
        "Listar discos")
            
            LISTAR_DISCOS
            ;;
        "Option 3")
            clear
            echo "you chose choice $REPLY which is $opt"
            ;;
        "Quit")
            break
            ;;
        *) 
        clear
        echo "Opção invalida: $REPLY";;
    esac
done

#comandos para clonar
#dd if=/dev/sda bs=4M | gzip -c | split -b 2G - /mnt/backup_sda.img.gz

#cat /mnt/UDISK1T/backup_sda.img.gz.* | gzip -dc | dd of=/dev/sda bs=4M



