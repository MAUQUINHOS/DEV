#!/bin/bash
#
# Check Open Port using to site Can You See Me
# Referece FORM POST:  https://ports.yougetsignal.com/check-port.php
#
# How to use
#
# For check a Port in Address use: ./check_port.sh PORT
# ex: ./check_port.sh 8080
#
# For check Port in Remote Address use: ./check_port.sh IP_REMOTE PORT
# ex: ./check_port.sh 8.8.8.8 53
#
# Check permissions before use.
#
# IF check  exists IP_REMOTE
#
# Autor: http://bit.ly/MAUQUINHOS-GIT
# RAW  : https://raw.githubusercontent.com/MAUQUINHOS/DEV/master/SHELL/PORTS/check_port.sh
# 
clear
echo -e "Check PORT ONLINE\n"
if [ -z "$2" ]
then
# Check Port in your IP Gateway
        curl -X POST -F "portNumber=$1" https://ports.yougetsignal.com/check-port.php 2>&1 | grep -qi "open" && echo -e "\tPORT: $1 OPEN" || echo -e "\tPORT: $1 CLOSED"

else
# Check Port in Remote IP
        case `curl -X POST -F "remoteAddress=$1" -F "portNumber=$2" https://ports.yougetsignal.com/check-port.php 2>&1 | grep -qi "open"; echo $?` in
          0)
            echo -e "\tPort $2 in $1 OPEN"
            ;;
          1)
            echo -e "\tPort $2 in $1 CLOSED"
            ;;
          *)
            echo -e "\t Contais an ERROR!"
            ;;
        esac
fi
echo ""
