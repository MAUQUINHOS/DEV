#!/usr/bin/python
# -*- coding: utf-8 -*-
# Bibliotecas
import struct
import time
import sys
#
# Codigo modificado
# Original file: https://stackoverflow.com/questions/5060710/format-of-dev-input-event/10665053
#
# Para detectar o evento:  ls -l  /dev/input/by-{path,id}/ 
# RESPOSTA: usb-Sycreader_RFID_Technology_Co.__Ltd_SYC_ID_IC_USB_Reader_08FF20140315-event-kbd -> ../event4

# Caminho do arquivoque ser   lido
infile_path = "/dev/input/event4"
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
PASS=""
#
# APOS A LEITURA, CRIA UM LACO E TRADUZ O CODE
while event:
        (tv_sec, tv_usec, type, code, value) = struct.unpack(FORMAT, event)
        if code != 0 and value != 0:
                print(event)
                if code == 11:
                        PASS += "0"
                if code == 2:
                        PASS += "1"
                elif code == 3:
                        PASS += "2"
                elif code == 10:
                        PASS += "3"
                        print("Event type %u, code %u, value %u at %d.%d" % (type, code, value, tv_sec, tv_usec))
                elif code == 5:
                        PASS += "4"
                elif code == 6:
                        PASS += "5"
                elif code == 7:
                        PASS += "6"
                elif code == 8:
                        PASS += "7"
                elif code == 9:
                        PASS += "8"
                elif code == 28:
                        PASS += "9"
                        print("Event type %u, code %u, value %u at %d.%d" % (type, code, value, tv_sec, tv_usec))
# CHECA A SENHA E IMPRIME
        if len(PASS) > 9:
                print("ID: "+PASS)
                PASS=""
        event = in_file.read(EVENT_SIZE)
# FECHA O ARQUIVO

