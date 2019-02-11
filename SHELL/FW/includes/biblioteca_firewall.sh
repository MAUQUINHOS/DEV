#!/bin/bash
#firewall do sistema
firewall(){
 opt_iptables=$(dialog --backtitle "MENU > FIREWAll" --stdout --menu "Selecione uma opção" 0 0 0 \
 Regras 'Verifica regras e politicas de acesso' \
 ICMP 'Adiciona Host para Ping ICMP' \
 LogsFW 'Verificação de logs do sistema' \
 Repo 'Libera trafego em direção aso repositórios' \
 SSHRemoto 'Acesso remoto administrador' \
 Descarregar '-F -X descarrega as regras padrões' \
 Restart 'reinicia a configuração'  \
 Backup 'BACKUP das configurações')
 case $opt_iptables in
  Regras) list_fw;;
  ICMP) icmp1_fw;;
  Repo) repo_fw;;
  SSHRemoto) ssh_remoto;;
  Descarregar) flush_fw;;
  LogsFW) logs_fw;;
  Restart) restart_iptables;;
  Backup) backup_config;;
  *) menu;;
 esac
}

backup_config(){
	iptables-save > iptables.bckp
	save=$(cat iptables.bckp)
	dialog --msgbox "$save" 40 80
	}

logs_fw(){
opt_logsfw=$(dialog --backtitle "FIREWALL > LOGS FIREWALL" --stdout --menu "Selecione uma opcao" 0 0 0 \
NETSTAT 'netstat -t -l -p --numeric-ports' \
NF_CONNTRACK 'cat /proc/net/nf_conntrack' \
MESSAGES '/var/log/messages' )
case $opt_logsfw in
  NETSTAT) 'netstat_log';;
  NF_CONNTRACK) 'conexoes_nfcontrack';;
  MESSAGES) 'messages_log';;
  *) firewall; dialog --msgbox "Opção invalida" 10 40 ;;
esac
}
netstat_log(){
  conexoes_logs=$(netstat -t -l -p --numeric-ports)
  dialog --msgbox "$conexoes_logs" 80 100
  logs_fw
}
conexoes_nfcontrack(){
  tabela=$(cat /proc/net/nf_conntrack)
  dialog --msgbox "$tabela" 80 100
  logs_fw
 }
messages_log(){
  logs_fw=$(tail /var/log/messages)
  dialog --msgbox "$logs_fw" 80 100
  logs_fw
}



antiatack(){
eth=$( ifconfig | grep -w "Ethernet" | awk '{print $1}')
###### Protege contra synflood
  /sbin/iptables -A FORWARD -p tcp --syn -m limit --limit 1/s -j ACCEPT
  echo 1 > /proc/sys/net/ipv4/tcp_syncookies
###### Prote.. Contra IP Spoofing
echo 1 > /proc/sys/net/ipv4/conf/all/rp_filter
###### Protecao diversas contra portscanners, ping of death, ataques DoS, pacotes danificados e etc.
/sbin/iptables -A FORWARD -p icmp --icmp-type echo-request -m limit --limit 1/s -j ACCEPT
/sbin/iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit 1/s -j ACCEPT
/sbin/iptables -A INPUT -i $eth -p icmp --icmp-type echo-reply -m limit --limit 1/s -j DROP
/sbin/iptables -A FORWARD -p tcp -m limit --limit 1/s -j ACCEPT
/sbin/iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
/sbin/iptables -A FORWARD -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s -j ACCEPT
/sbin/iptables -A FORWARD --protocol tcp --tcp-flags ALL SYN,ACK -j DROP
/sbin/iptables -A INPUT -m state --state INVALID -j DROP
/sbin/iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
/sbin/iptables -N VALID_CHECK
/sbin/iptables -A VALID_CHECK -p tcp --tcp-flags ALL FIN,URG,PSH -j DROP
/sbin/iptables -A VALID_CHECK -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP
/sbin/iptables -A VALID_CHECK -p tcp --tcp-flags ALL ALL -j DROP
/sbin/iptables -A VALID_CHECK -p tcp --tcp-flags ALL FIN -j DROP
/sbin/iptables -A VALID_CHECK -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
/sbin/iptables -A VALID_CHECK -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP
/sbin/iptables -A VALID_CHECK -p tcp --tcp-flags ALL NONE -j DROP
 dialog --msgbox "Proteção ativa" 8 40

}


ssh_remoto(){
eth=$( ifconfig | grep -w "Ethernet" | awk '{print $1}')
opt_ssh_remoto=$(dialog --backtitle "FIREWALL > SSH REMOTO" --stdout --menu "Selecione uma opcao" 0 0 0 \
ADD_MAC_REM 'adiciona MAC conexao remota' \
DEL_MAC_REM 'deleta MAC conexao remotao' );
case $opt_ssh_remoto in
  ADD_MAC_REM) add_mac_remoto;;
  DEL_MAC_REM) del_mac_remoto;;
  *) firewall;;
esac
}
add_mac_remoto(){
  mac_adm=$(dialog --backtitle "ADD MAC HOST REMOTO" --stdout --nocancel --inputbox "Digite o MAC do Administrador \n no formato válido ex:08:00:27:92:63:06" 10 50);
  iptables -A INPUT -p tcp --destination-port 22 -m mac --mac-source $mac_adm -j LOG --log-prefix "SSH" --log-level info
  iptables -A INPUT -p tcp --destination-port 22 -m mac --mac-source $mac_adm -j ACCEPT
  if [ $? -eq 0 ]
  then
    dialog --msgbox "adicionado com sucesso" 8 40
    list_fw
  else
    dialog --msgbox "Ocorreu um erro" 8 40
  fi
  firewall
}
del_mac_remoto(){
  mac_adm=$(dialog --backtitle "ADD MAC HOST REMOTO" --stdout --nocancel --inputbox "Digite o MAC do Administrador \n no formato válido ex: 08:00:27:92:63:06" 10 50);
  iptables -D INPUT -p tcp --destination-port 22 -m mac --mac-source $mac_adm -j LOG --log-prefix "SSH" --log-level info
  iptables -D INPUT -p tcp --destination-port 22 -m mac --mac-source $mac_adm -j ACCEPT
  if [ $? -eq 0 ]
  then
    dialog --msgbox "Removido com sucesso" 8 40
    list_fw
  else
    dialog --msgbox "Ocorreu um erro" 8 40
  fi
  firewall
 }

repo_fw(){
eth=$( ifconfig | grep -w "Ethernet" | awk '{print $1}')
opt_repo=$(iptables -D OUTPUT -o $eth -d pkgs.repoforge.org -j ACCEPT)
 if [ $? -eq 0 ]
 then
  iptables -D OUTPUT -o $eth -d pkgs.repoforge.org -j LOG --log-prefix "ATUALIZACAO_SISTEMA" --log-level info
  iptables -D OUTPUT -o $eth -d pkgs.repoforge.org -j ACCEPT
  dialog --msgbox "Serviço removido" 8 40
 else
  iptables -A OUTPUT -o $eth -d pkgs.repoforge.org -j LOG --log-prefix "ATUALIZACAO_SISTEMA" --log-level info
  iptables -A OUTPUT -o $eth -d pkgs.repoforge.org -j ACCEPT
  dialog --msgbox "Sistema liberado para atualizar" 8 40
 fi
list_fw
}
list_fw(){
 listar_fw=$(iptables -vnL --line-numbers)
  if [ $? -eq 0 ]
  then
    dialog --msgbox "$listar_fw" 50 80
  else
    dialog --msgbox "Ocorreu algum erro" 10 50
  fi
firewall
}

icmp1_fw(){
eth=$( ifconfig | grep -w "Ethernet" | awk '{print $1}')
opt_icmp=$(dialog --backtitle "FIREWALL > ICMP " --stdout --menu "Selecione uma opcao" 0 0 0 \
ADD_ICMP_REM 'adiciona icmp remoto' \
DEL_ICMP_REM 'deletaiciona icmp remoto' );
case $opt_icmp in
  ADD_ICMP_REM) add_icmp_remoto;;
  DEL_ICMP_REM) del_icmp_remoto;;
  *) firewall;;
esac
}
del_icmp_remoto(){
ip_adm=$(dialog --backtitle "MENU" --stdout --nocancel --inputbox "Digite o IP do Administrador \n no formato válido #.#.#.#" 10 50);
iptables -D INPUT -i $eth -s $ip_adm -p icmp --icmp-type echo-request -j LOG --log-prefix "ICMP_REMOTO" --log-level info
iptables -D INPUT -i $eth -s $ip_adm -p icmp --icmp-type echo-request -j ACCEPT
if [ $? -eq 0 ]
  then
    dialog --msgbox "Removido com sucesso" 8 40
else
    dialog --msgbox "Ocorreu algum erro" 10 50
fi
list_fw
}
add_icmp_remoto(){
ip_adm=$(dialog --backtitle "MENU" --stdout --nocancel --inputbox "Digite o IP do Administrador \n no formato válido #.#.#.#" 10 50);
iptables -A INPUT -i $eth -s $ip_adm -p icmp --icmp-type echo-request -j LOG --log-prefix "ICMP_REMOTO" --log-level info
iptables -A INPUT -i $eth -s $ip_adm -p icmp --icmp-type echo-request -j ACCEPT
if [ $? -eq 0 ]
  then
    dialog --msgbox "Comando adicionado" 10 50
else
    dialog --msgbox "Ocorreu algum erro" 10 50
fi
list_fw
}

flush_fw(){
  iptables -F
  iptables -X
  if [ $? -eq 0 ]
  then
    dialog --msgbox "Flush aplicado com sucesso!" 8 40
  else
    dialog --msgbox "Ocorreu algum erro." 8 40
  fi
  list_fw
}

restart_iptables(){
service iptables stop
service httpd stop
service iptables start
service httpd start
firewall
}




