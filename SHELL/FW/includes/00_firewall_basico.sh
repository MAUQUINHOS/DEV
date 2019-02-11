#!/bin/bash
#caminho do iptables
ipt=$(which iptables)
#decarregar regras padrãoe as regras de usuarios
$ipt -F
$ipt -X
#Politicas padrão do sistema
$ipt -P INPUT DROP    #dropa todas as entradas
$ipt -P OUTPUT DROP   #dropa todas saidas
$ipt -P FORWARD DROP  #drop o encaminhamento de rede interno
#liberar o loopback
$ipt -A INPUT -i lo -j ACCEPT
$ipt -A OUTPUT -o lo -j ACCEPT

#Ativa a inspeção StateFul
eth=$( ifconfig | grep -w "Ethernet" | awk '{print $1}')
$ipt -A OUTPUT -o $eth -d 0/0 -m state --state ESTABLISHED -j ACCEPT


# -P Politicas
# -A insere na ordem natural da pilha
# -i input
# -o output
