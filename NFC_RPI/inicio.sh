#!/bin/bash
#
###########################################################
#
#  Script desenvolvido para Obtenção de Graduação
#  em Segurança da Informação na Fatec São Caetano do Sul
#  com a Orientação do Prof: Ismael Parede 2019
#
###########################################################
#
# Iniciando o servidor WEB
SERVER_WEB=$(python -m server.py & echo $!)
# Ativa o Leitor NFC
LEITOR_NFC=$(python read_nfc.py & echo $!)
echo "Para matar os servicos"
echo -e "\tsudo kill -9 $LEITOR_NFC"
echo -e "\tsudo kill -9 $SERVER_WEB"
