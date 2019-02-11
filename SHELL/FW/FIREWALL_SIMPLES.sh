#!/bin/bash 
################################
#Ativa o bloqueio das teclas CTRL
trap ctrl_c INT
trap 'dialog --msgbox "Voce não pode fazer isto" 8 40; menu' SIGINT
trap 'dialog --msgbox "Voce não pode fazer isto" 8 40; menu' SIGQUIT
trap 'dialog --msgbox "Voce não pode fazer isto" 8 40; menu' SIGTSTP
#Inicio do sistema 

#Bibliotecas Basicas
HR=/root/Osmany
. $HR/includes/biblioteca_ativacao_servicos.sh
. $HR/includes/biblioteca_firewall.sh
. $HR/includes/biblioteca_discos.sh
. $HR/includes/biblioteca_usuarios.sh

#Adiciona regras basicas de firewall
. $HR/includes/00_firewall_basico.sh
#Restaura ultimas configurações
if [ -f iptables.bckp ]
then
  dialog --title "Restaurar ultima configuração?" \
  --backtitle "Existe uma configuração salva, deseja restaurar?" \
  --yesno "Arquivo: iptables.bckp" 7 60
  if [ $? -eq 0 ]
  then
    iptables-restore < iptables.bckp
  fi
fi

#Verifica serviços que rodam na maquina
. $HR/includes/01_servicos_ativos.sh

#Validação de usuario
. $HR/includes/02_valida_usuario.sh
