#! /usr/bin/python
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
PORT_RED=4
#DEFININDO FUNCAO LED RED
def func_ledr():
# RESET PORTA RED
        GPIO.setup(PORT_RED,GPIO.OUT)
#ATIVA LED RED
        GPIO.output(PORT_RED,GPIO.HIGH)
        print("outut: HIgh")
        time.sleep(2) 

#SELECIONA FUNCAO QUE VAI RODAR
func_ledr();

#DESATIVA LED RED NA PORTA
GPIO.output(PORT_RED,GPIO.LOW)
