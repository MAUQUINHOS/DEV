#!/usr/bin/python
# Bibliotecas
import struct
import time
import sys
#
# Codigo modificado
# Original file: https://stackoverflow.com/questions/5060710/format-of-dev-input-event/10665053
#
# Para detectar o evento:  ls -l  /dev/input/by-{path,id}/ 
# Caminho do arquivoque será lido
infile_path = "/dev/input/event0"
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
				PASS += "0"
		if code == 79:
				PASS += "1"
		elif code == 80:
				PASS += "2"
		elif code == 81:
				PASS += "3"
		elif code == 75:
				PASS += "4"
		elif code == 76:
				PASS += "5"
		elif code == 77:
				PASS += "6"
		elif code == 71:
				PASS += "7"
		elif code == 72:
				PASS += "8"
		elif code == 73:
				PASS += "9"
# CHECA A SENHA E IMPRIME
		if code == 96 and len(PASS) >= 6 and len(PASS) <= 20:
				print(PASS)
				PASS=""
		elif code == 96:
				print("SENHA FORA DO PADRAO  6 >= <= 20")
				PASS=""
    event = in_file.read(EVENT_SIZE)
# FECHA O ARQUIVO
in_file.close()
