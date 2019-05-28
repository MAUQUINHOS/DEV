#!/usr/bin/python
#ENCODE UTF-8
# -*- coding: utf-8 -*-
#BIBLIOTECAS
import sys
import RPi.GPIO as GPIO
import time 
#
#SELECIONANDO GPIO mode
GPIO.setmode(GPIO.BCM)
#
#DESATIVANDO ALARMES (optional)
GPIO.setwarnings(False) 
#
#SETANDO AS PORTAS GPIO
PORT_RED=20 # LED RED
PORT_GREEN=21 # LED GREEN
PORT_BUZZ=26 # BUZZER
#
#VARIAVEIS DO SISTEMA
x=sys.argv[1] #DEFINE QUAL FUNCAO RODAR ATRAVES DE PARAMETROS (R|G|B = red | green | buzzer )
#
#DEFININDO FUNCAO LED RED
def func_ledr(sec, voltas):
	i=1
# RESET PORTA RED
	GPIO.setup(PORT_RED,GPIO.OUT)
#
# VARIAVEIS LOCAIS ARGS SEC(argv[2]) VOLTAS(argv[3])
	sec=float(sec)
	voltas=int(voltas)
#
# ATIVA BUZZER
	func_buz(0.3,3)
#
# LACO
	while(i <= voltas ):
#		ATIVA LED RED
		GPIO.output(PORT_RED,GPIO.HIGH) 
		time.sleep(0.2) 
#		DESATIVA LED RED NA PORTA
		GPIO.output(PORT_RED,GPIO.LOW)
		time.sleep(sec)
		i += 1
# RESET PORTA RED
	GPIO.setup(PORT_RED,GPIO.OUT) 
# FIM DO LACO
#
#DEFININDO FUNCAO LED GREEN
def func_ledg(sec, voltas):
	i=1
# RESET PORTA GREEN
	GPIO.setup(PORT_GREEN,GPIO.OUT)
#
# VARIAVEIS LOCAIS ARGS SEC(argv[2]) VOLTAS(argv[3])
	sec=float(sec)
	voltas=int(voltas)
#
# ATIVA BUZZER
  	func_buz(0.1,2)
#
# LACO
	while(i <= voltas ):
#		ATIVA LED GREEN
		GPIO.output(PORT_GREEN,GPIO.HIGH) 
		time.sleep(0.2) 
#		DESATIVA LED GREEN
		GPIO.output(PORT_GREEN,GPIO.LOW)
		time.sleep(sec)
		i += 1
# RESET PORTA GREEN
	GPIO.setup(PORT_GREEN,GPIO.OUT) 
# FIM DO LACO LED GREEN
#
#DEFININDO FUNCAO BUZZER
def func_buz(sec, voltas):
	i=1
#
# VARIAVEIS LOCAIS ARGS SEC(argv[2]) VOLTAS(argv[3])
	sec=float(sec)
	voltas=int(voltas)
#
# RESET PORTA BUZZER
	GPIO.setup(PORT_BUZZ,GPIO.OUT)
# LACO
	while(i <= voltas ):
#		ATIVA BUZZER
		GPIO.output(PORT_BUZZ,GPIO.HIGH)
		time.sleep(0.1)
#		DESATIVA BUZZER
		GPIO.output(PORT_BUZZ,GPIO.LOW)
		time.sleep(sec)
		i += 1
# RESET PORTA GREEN
	GPIO.setup(PORT_BUZZ,GPIO.OUT) 
# FIM DO LACO BUZZER
#
#SELECIONA FUNCAO QUE VAI RODAR
if x == 'b':
	func_buz(sys.argv[2],sys.argv[3])
if x == 'g':
	func_ledg(sys.argv[2],sys.argv[3])
if x == 'r':
	func_ledr(sys.argv[2],sys.argv[3])
