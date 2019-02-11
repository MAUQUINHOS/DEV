#!/bin/bash
#verificação e ativação ou desativação de serviços
servicos(){
 opt_servicos=$(dialog --backtitle "MENU > SERVIÇOS" --stdout --menu "Selecione o serviço que deseja" 0 0 0 \
 SSH 'secure shell' \
 APACHE 'web server')
 case $opt_servicos in
  SSH) servico_ssh;;
  APACHE) servico_apache;;
  *) menu;;
 esac
}
servico_ssh(){
 ssh_status=$(service sshd status | cut -d" " -f6)
 if [ "$ssh_status" == "running..." ]
 then
  ssh_status=$(dialog --backtitle "APACHE" --stdout --menu "Serviço ativo, deseja desativar?" 0 0 0 \
  Desativar 'desativar o serviço')
  if [ "$ssh_status" == "Desativar" ]
  then
   ssh_status="parado "
   service sshd stop
  else
   ssh_status="rodando"
  fi
 else
  ssh_status=$(dialog --backtitle "APACHE" --stdout --menu "Serviço parado, deseja ativar?" 0 0 0 \
  Ativar 'Ativa o serviço')
  if [ "$ssh_status" == "Ativar" ]
  then
   ssh_status="rodando"
   service sshd start
  else
  ssh_status="parado "
  fi
 fi
menu
}
servico_apache(){
 apache_status=$(service httpd status | cut -d" " -f3)
 if [ "$apache_status" == "stopped" ]
 then
  apache_status=$(dialog --backtitle "APACHE" --stdout --menu "Serviço desativado, deseja rodar?" 0 0 0 \
  Ativar 'ativa o serviço')
  if [ "$apache_status" == "Ativar" ]
  then
   apache_status="rodando"
   service httpd start
  else
   apache_status="parado "
  fi
 else
  apache_status=$(dialog --backtitle "APACHE" --stdout --menu "Serviço rodando, deseja parar?" 0 0 0 \
  Desativar 'Desativa o serviço')
  if [ "$apache_status" == "Desativar" ]
  then
   apache_status="parado "
   service httpd stop
  else
  apache_status="rodando" 
  fi
 fi
 menu
}
