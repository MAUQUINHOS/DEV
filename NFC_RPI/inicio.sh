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
# Limpando a tela
clear
#
# Detectando EVENTO NFC e TECLADO
EVENTO_NFC=$(ls -l  /dev/input/by-{path,id}/ | grep RFID | cut -d"/" -f2)
EVENTO_NUMPAD=$(ls -l  /dev/input/by-{path,id}/ | grep "event-kbd" | grep -v "$EVENTO_NFC" | cut -d"/" -f2 | sort -u)
echo -e "1- VERIFIQUE SE OS EVENTOS ESTAO CONFIGURADOS\n\n\t   NFC: $EVENTO_NFC \n\tNUMPAD: $EVENTO_NUMPAD\n"
#
echo -e "2- PARA FINALIZAR TAREFAS, USE:\n"
# Iniciando o servidor WEB
python -m server.py & echo -e "\tsudo kill -9 $!"
# Ativa o Leitor NFC
python read_nfc.py $EVENTO_NFC & echo -e "\tsudo kill -9 $!"
echo ""
