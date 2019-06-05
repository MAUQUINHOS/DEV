#!/usr/bin/python
# -*- coding: utf-8 -*-
# Bibliotecas
import struct,time, sys
from subprocess import call # Comando Call
from datetime import datetime # Comando DATE
now = datetime.now() # current date and time
#
##########################
# MAPEAMENTO DAS TECLAS
#    if code == 11:
#        PASS += "0"
#    elif code == 10:
#        PASS += "9"
#    elif code == 4 and value == 1:
#        PASS += "3"
#    elif code == 2:
#        PASS += "1"
#    elif code == 3:
#        PASS += "2"
#    elif code == 5:
#        PASS += "4"
#    elif code == 6:
#        PASS += "5"
#    elif code == 7:
#        PASS += "6"
#    elif code == 8:
#        PASS += "7"
#    elif code == 9:
#        PASS += "8"
##########################
#
# Codigo modificado
# Original file: https://stackoverflow.com/questions/5060710/format-of-dev-input-event/10665053
#
# Para detectar o evento:  ls -l  /dev/input/by-{path,id}/ 
# usb-Sycreader_RFID_Technology_Co.__Ltd_SYC_ID_IC_USB_Reader_08FF20140315-event-kbd -> ../event4
# CAMINHO DA LEITURA
EVENTO1=sys.argv[1]
infile_path ="/dev/input/"+EVENTO1
print("")
print("3- LENDO NFC")
# Formata    o do STRUCT
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
IDNFC=""
INFO=""
#
# APOS A LEITURA, CRIA UM LACO E TRADUZ O CODE
while event:
        (tv_sec, tv_usec, type, code, value) = struct.unpack(FORMAT, event)
        if value != 0 and code != 0:			
			if code == 11:
					IDNFC += "0"
			elif code == 10:
					IDNFC += "9"
			elif code == 4 and value == 1:
					IDNFC += "3"
			elif code == 2:
					IDNFC += "1"
			elif code == 3:
					IDNFC += "2"
			elif code == 5:
					IDNFC += "4"
			elif code == 6:
					IDNFC += "5"
			elif code == 7:
					IDNFC += "6"
			elif code == 8:
					IDNFC += "7"
			elif code == 9:
					IDNFC += "8"                           
# CHECA A IDNFC E IMPRIME
			if len(IDNFC) == 10:
				print("4- IMPRIMINDO NFC")
				INFO = IDNFC
# QUERY NO SQL
				call('./select_sql.sh root abc123 nfc '+INFO, shell=True)
#				print("Chamando select.sql"+INFO)
				INFO = IDNFC = ""
			elif len(IDNFC) > 10:
				INFO = IDNFC = ""				      
        event = in_file.read(EVENT_SIZE)
# FECHA O ARQUIVO
in_file.close()
  

