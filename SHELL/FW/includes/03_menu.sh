#!/bin/bash
#Menu principal
menu(){
menu=$(dialog --backtitle "MENU" --stdout --nocancel --inputbox "\\n
   __________________________________________________________  \\n
  |                           |                              | \\n
  | GERENCIAMENTO DE FIREWALL |  FATEC SÃO CAETANO DO SUL    | \\n
  |___________________________|         SEGNA 3 Profº Osmany | \\n
  | Opções____________________|______________________________| \\n
  |                           | \\n
  | 1) Usuários |             |  HOSTNAME: $(hostname) IP: $(hostname -I | cut -d' ' -f1) \\n
  | 2) Serviços |             |      USER: $USER \\n
  | 3) Firewall |    0) Sair  |    VERSÃO: $(cat /etc/*-release | uniq) \\n
  | 4) Discos   |             |    KERNEL: $(uname -ar | awk '{print $1 ":" $3}') \\n
  | 5) AntiAtack|             |       RAM: $( free | grep Mem | awk '{print $3/$2 * 100.0}' | cut -d'.' -f1 ) % \\n
  |                           |       VAR: $(df -h | grep var | awk '{print $5 }') $(df -h | grep -w "/var" | mdadm --detail $(awk '{print $1}') | grep -w "Level" | cut -d":" -f2) \\n
  |___________________________|      SWAP: $( free | grep Swap | awk '{print $3/$2 *100.0}' | cut -d'.' -f1 ) %  \\n
  | Serviços__________________|         /: $(df -h | grep -w "/" | awk '{print $5}') $(df -h | grep -w "/" | mdadm --detail $(awk '{print $1}') | grep -w "Level" | cut -d":" -f2 ) \\n
  |                           |      BOOT: $(df -h | grep -w "/boot" | awk '{print $5}') $(df -h | grep -w "/boot" |  mdadm --detail $(awk '{print $1}') | grep -w "Level" | cut -d":" -f2) \\n
  |   APACHE:  $apache_status        | \\n
  |      SSH:  $ssh_status        | \\n
  |                           | \\n
  |___________________________|                   $(uptime | awk '{print "UPTIME " $1}')" -1 -1);clear

 case $menu in
  0) fn_sair;;
  1) usuarios;;
  2) servicos;;
  3) firewall;; 
  4) discos;;  
  5) antiatack;;
 # 7) help;; 
 # A) administrador;;
  *) dialog --msgbox "Opção inválida" 8 40; menu;;
 esac
}

fn_sair(){
#Salva backup ao sair
if [ -f iptables*.bckp ]
then
  dialog --title "Existe uma configuração salva, deseja sbuscrever?" \
  --backtitle "Existe uma configuração salva, deseja sbuscrever?" \
  --yesno "Arquivo: iptables.bckp" 7 60
  if [ $? -eq 0 ]
  then
    iptables-save > iptables.bckp
  fi
else
  dialog --title "Você não salvou a configuração, deseja salvar?" \
  --backtitle "Você não salvou a configuração, deseja salvar?" \
  --yesno "Arquivo: iptables.bckp" 7 60
  if [ $? -eq 0 ]
  then
    iptables-save > iptables.bckp
  fi
fi
clear
exit 0;
}
