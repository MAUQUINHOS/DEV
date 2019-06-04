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
python -m server.py & echo -e "\tsudo kill -9 $!"
# Ativa o Leitor NFC
python read_nfc.py & echo -e "\tsudo kill -9 $!"
