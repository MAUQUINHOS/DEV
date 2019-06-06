#!/usr/bin/python
# -*- coding: utf-8 -*-
# Bibliotecas
import struct, time, sys
import alertas
#
#
##########################
# MAPEAMENTO DAS TECLAS
#    code == 11:print("0")
#    code == 2:	print("1")
#    code == 3:	print("2")
#    code == 5:	print("4")
#    code == 6:	print("5")
#    code == 7:	print("6")
#    code == 8:	print("7")
#    code == 9:	print("8")
#    code == 10:print("9")
##########################
#
# Codigo modificado
# Original file: https://stackoverflow.com/questions/5060710/format-of-dev-input-event/10665053
#
# Para detectar o evento:  ls -l  /dev/input/by-{path,id}/ 
# Caminho do arquivoque será lido
EVENTO2=sys.argv[1]
infile_path ="/dev/input/"+EVENTO2
# Formatação do STRUCT
#long int, long int, unsigned short, unsigned short, unsigned int
FORMAT = 'llHHI'
EVENT_SIZE = struct.calcsize(FORMAT)
#
# Abre o arquivo  no caminho do PATH, modo READ/BIN
in_file = open(infile_path, "rb")
#
# VERIFICA BUFFER E QUAL TAMANHO
event = in_file.read(EVENT_SIZE)
#
# VARIAVEIS AMBIENTE
PASS=""
#
# APOS A LEITURA, CRIA UM LACO E TRADUZ O CODE
while event:
    (tv_sec, tv_usec, type, code, value) = struct.unpack(FORMAT, event)
    if code != 0 and value != 0:
#		print("Code: %u, Valor: %u " % (code, value))
		if code == 82:
				alertas.func_buz(0.00001,1)
				PASS += "0"
		if code == 79:
				alertas.func_buz(0.00001,1)
				PASS += "1"
		elif code == 80:
				alertas.func_buz(0.00001,1)
				PASS += "2"
		elif code == 81:
				alertas.func_buz(0.00001,1)
				PASS += "3"
		elif code == 75:
				alertas.func_buz(0.00001,1)
				PASS += "4"
		elif code == 76:
				alertas.func_buz(0.00001,1)
				PASS += "5"
		elif code == 77:
				alertas.func_buz(0.00001,1)
				PASS += "6"
		elif code == 71:
				alertas.func_buz(0.00001,1)
				PASS += "7"
		elif code == 72:
				alertas.func_buz(0.00001,1)
				PASS += "8"
		elif code == 73:
				alertas.func_buz(0.00001,1)
				PASS += "9"
# CHECA A SENHA E IMPRIME
		if code == 96 and len(PASS) >= 5 and len(PASS) <= 20:
				alertas.func_buz(0.001,2)
				alertas.func_buz(0.01,1)
				print(PASS)
				break;
				PASS=""
		elif code == 96:
				print("SENHA FORA DO PADRAO  6 >= <= 20")
				PASS=""
    event = in_file.read(EVENT_SIZE)
# FECHA O ARQUIVO
in_file.close()
