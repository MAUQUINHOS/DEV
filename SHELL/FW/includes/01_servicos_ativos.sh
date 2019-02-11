#!/bin/bash
#Verificação de seviços que rodam em segundo plano
echo "10 " | dialog --title "Firewall" --gauge "Analisando serviços." 10 70 0
apache_status=$(service httpd status | cut -d" " -f3)
if [ "$apache_status" == "stopped" ]
then
 apache_status="parado "
else
 apache_status="rodando"
fi
echo "30 " | dialog --title "Firewall" --gauge "Analisando serviços." 10 70 0
ssh_status=$(service sshd status | cut -d" " -f6)
if [ "$ssh_status" == "running..." ]
then
 ssh_status="rodando"
else
 ssh_status="parado "
fi
echo "70 " | dialog --title "Firewall" --gauge "Analisando serviços." 10 70 0
delay 1
echo "100 " | dialog --title "Firewall" --gauge "Carregado!!" 10 70 0
