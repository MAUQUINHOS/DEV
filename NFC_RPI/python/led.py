# Referencias
#
#https://www.instructables.com/id/Control-LED-Using-Raspberry-Pi-GPIO/


import RPi.GPIO as GPIO
import time 
GPIO.setmode(GPIO.BCM) 
GPIO.setwarnings(False) 
GPIO.setup(21,GPIO.OUT) 
print "LED on" 
GPIO.output(21,GPIO.HIGH) 
time.sleep(10) 
print "LED off" 
GPIO.output(21,GPIO.LOW)
