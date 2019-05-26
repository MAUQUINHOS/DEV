#coding: utf-8
#!/bin/python
import sys
from time import sleep
#
# Referencias
# https://www.instructables.com/id/Raspberry-Pi-Tutorial-How-to-Use-a-Buzzer/
#
# laco de repetição
# arg1 = 0.9 /segundos ou milesimos 
# arg2 = 3   /numeros de voltas do laco 
#
# Funcionamento
#
# python teste_parametros.py arg1 arg2
# python teste_parametros.py 0.3 1
#
# RecebeArgumentos
sec=float(sys.argv[1])
voltas=int(sys.argv[2])
#Contador
i=1
#Imprime Laco
while(i <= voltas ):
	print(voltas)
	sleep(sec)
	i += 1
