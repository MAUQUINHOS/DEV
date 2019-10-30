#!/bin/bash
#
# Check Online Open Port using to site Can You See Me
#
# How to use: ./check_port.sh 8888
#
# BUFF for checking using IF
BUFF=$(curl --data "port=$1" https://www.canyouseeme.org/ 2>&1 | grep "Success" | grep -o '<b>.*</b>' | sed 's/\(<b>\|<\/font>\|(\|<\/b>\)//g' | cut -d";" -f2)
#
[[ ${#BUFF} -eq 0 ]] && { echo "Port: $1, is closed" >&2; exit 1; }
#
# Simple print output
curl --data "port=$1" https://www.canyouseeme.org/ 2>&1 | grep "Success" | grep -o '<b>.*</b>' | sed 's/\(<b>\|<\/font>\|(\|<\/b>\)//g' | cut -d";" -f2
