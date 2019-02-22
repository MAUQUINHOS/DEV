#!/bin/bash
#
# Este programa serve para clonagem de HD's, Pendrive, CD'd, DVD's e etc..
# ./clone_disk.sh #Clona discos com terminal
#
#
#
# Check usuario root
ID=$(id | grep "root")
[[ "$ID" ]] || { clear; echo 'Você não é root, e não consegue executar!' >&2; exit 1; }
#
# Verifica atende os requisitos necessários para execução do código
read programas <<< "$(which dd 2> /dev/null)"
#
# Condição de requisistos 
[[ "$programas" ]] || {   echo 'neither whiptail nor dialog found' >&2;   exit 1; }
#
#
SELECIONAR_DISCOS(){
  # Lista todos os discos disponiveis na computador
  DISCOS=$(lsblk -dp | grep -e "disk\|rom" | awk -F" " '{print "\""$1"\" " "\"Type: "$6"\" OFF "}' | tr '\n' ' ')

  # Cria a msgbox listando os disco encontrados armazenados em $DISCOS
  TESTE='whiptail --title "SELECIONAR DISCO" --radiolist "Escolha um disco que será copiado:" 15 60 4 '$DISCOS' 3>&1 1>&2 2>&3;'

  # O eval executa a função contida na variavel $TESTE e armazena seu resultado em $DISCOS
  DISCOS=$(eval "$TESTE")  
 
}

LISTAR_DISCOS(){
  # Lista todos os discos disponiveis na computador
  dsk=$(lsblk -dp | grep -e "disk\|rom" | awk -F" " '{print $1 " TIPO:" $6 " TAMANHO:" $4}' | sort -u)
   
  #Exibe os discos disponíveis em msgbox
  titulo="Listando discos"
  result="DISCOS:\n$dsk"
 
}

MENU(){
MNU="(1)Lista os discos | (2)Detalhes do disco | (3)Selecionar disco"
DISCOS=$(lsblk -dp | grep -e "disk\|rom" | awk -F" " '{print "|\n|__" $1 " \n|\tTIPO:" $6 " TAMANHO:" $4 "\n|"}')
clear
echo "DISCOS__________________________
|$MNU
$DISCOS
|________________________________"
}

DETALHAR_DISCO(){

  SELECIONAR_DISCOS

  titulo="Escolha o disco que será copiado"
  result=$(inxi -Fx | grep "$DISCOS" | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g")
  
  
}




while [ 1 ]
do

OPT=$(whiptail --title "Operative Systems" --menu "Make your choice" 16 100 9 \
	"1)" "Lista os discos"   \
	"2)" "Detalhes do disco"  \
	"3)" "Selecionar disco" \
	"5)" "How much time used in kernel mode and in user mode in the last secound." \
	"6)" "Break" \
	"9)" "End script" 3>&2 2>&1 1>&3)

case $OPT in

	"1)")   LISTAR_DISCOS
	;;
  
	"2)")   DETALHAR_DISCO
	;;
  
	"3)")   SELECIONAR_DISCOS
	;;

	"6)")   break
	;;

	"4)")   result=$(ps ax | wc -l)
	;;

	"9)") exit
        ;;
esac
whiptail --title "$titulo" --msgbox "$result" 20 78

done

#comandos para clonar
#dd if=/dev/sda bs=4M | gzip -c | split -b 2G - /mnt/backup_sda.img.gz

#cat /mnt/UDISK1T/backup_sda.img.gz.* | gzip -dc | dd of=/dev/sda bs=4M



