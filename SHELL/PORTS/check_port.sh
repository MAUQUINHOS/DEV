#!/bin/bash
#
# Check Open Port using to site OPEN PORTS CHECK TOOL
# Referece:  https://ports.yougetsignal.com/check-port.php
#
# Check the permissions before use
# How to use Check Ports Online V1
#
# For check one port in LOCAL ADDRESS from Internet use: ./check_port.sh PORT
# ex: ./check_port.sh 8080
# Output:
#  CHECK IP: 123.456.789
#	PORT: 8080 CLOSED
#
# For range of ports in LOCAL ADDRESS from Internet use: ./check_port.sh PORTx-PORTy
# ex: ./check_port.sh 8052-8053
# Output 
#  CHECK IP: 123.456.789
#	PORT: 8052 CLOSED
#	PORT: 8053 OPENED
#
## For check one port in REMOTE ADDRESS from Internet use: ./check_port.sh IP_REMOTE PORT
# ex: ./check_port.sh 8.8.8.8 443
# Output:
#  CHECK IP: 8.8.8.8 443
#	PORT: 443 OPENED
#
# For Range of ports in REMOTE ADDRESS from Internet use: ./check_port.sh REMOTE_IP PORTx-PORTy
# ex: ./check_port.sh 8.8.8.8 52-53
# Output 
#  CHECK IP: 8.8.8.8 443-445
#	PORT: 52 CLOSED
#	PORT: 53 OPENED
#
# Autor: http://bit.ly/MAUQUINHOS-GIT
# RAW  : https://raw.githubusercontent.com/MAUQUINHOS/DEV/master/SHELL/PORTS/check_port.sh
# 
clear
echo -e "CHECK PORTS ONLINE\n"
# Declare VAR's for parameters
VAR_p1=$1
VAR_p2=$2
# IF check exists Range in VAR's of parameters
if [ `echo $VAR_p1 | grep "-"` ] || [ `echo $VAR_p2 | grep "-"` ]
then
# Exists Ranges
 if [ -z "$VAR_p2" ]
 then
# Not exists VAR_p2"
# Echo IP from Gateway
  echo " CHECK IP: `curl -s ifconfig.me/ip 2>&1`"
# Create VAR's for seq in loop   
  [ `echo $VAR_p1 2>&1 | grep  "-"` ] && PAR1=$(echo $VAR_p1 2>&1 | cut -d"-" -f1); PAR2=$(echo $VAR_p1 2>&1 | cut -d"-" -f2);
  for PORT_NUMBER in $(seq $PAR1 $PAR2)
  do
# Loop for check many ports
   curl -X POST -F "portNumber=$PORT_NUMBER" https://ports.yougetsignal.com/check-port.php 2>&1 | grep -qi "open" && echo -e "\tPORT: $PORT_NUMBER OPENED" || echo -e "\tPORT: $PORT_NUMBER CLOSED" 
  done
#
 else
# Exists parameter 2, for get ports for into add on loop
# Check contains  Char(-) in VAR_p2
  [ `echo $VAR_p2 2>&1 | grep  "-"` ] && PAR1=$(echo $VAR_p2 2>&1 | cut -d"-" -f1); PAR2=$(echo $VAR_p2 2>&1 | cut -d"-" -f2);
  # Create loop  for check ports 
  echo "CHECK IP: $VAR_p1"
  for PORT_NUMBER in $(seq $PAR1 $PAR2)
  do
# Print ports from IP remote  
   curl -X POST -F "remoteAddress=$VAR_p1" -F "portNumber=$PORT_NUMBER" https://ports.yougetsignal.com/check-port.php 2>&1 | grep -qi "open" && echo -e "\tPORT: $PORT_NUMBER OPENED" || echo -e "\tPORT: $PORT_NUMBER CLOSED"
  done
 fi
#
else
# When not exists Range
 if ! [ -z "$VAR_p2" ]
 then
# Exists VAR_p2"
  curl -X POST -F "remoteAddress=$VAR_p1" -F "portNumber=$VAR_p2" https://ports.yougetsignal.com/check-port.php 2>&1 | grep -qi "open" && echo -e "\tPORT: $VAR_p2 OPENED" || echo -e "\tPORT: $VAR_p2 CLOSED"
 else
#  Not exists VAR_p2"
  echo " CHECK IP: `curl -s ifconfig.me/ip 2>&1`"
  curl -X POST -F "portNumber=$VAR_p1" https://ports.yougetsignal.com/check-port.php 2>&1 | grep -qi "open" && echo -e "\tPORT: $VAR_p1 OPENED" || echo -e "\tPORT: $VAR_p1 CLOSED"
 fi
#
fi
