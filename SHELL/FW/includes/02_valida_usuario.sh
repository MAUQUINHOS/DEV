#!/bin/bash
#Biblioteca menu
# Criação de um Loop infinito onde faz a verificação do usuario
# caso nosso usuario seja o root obtem acesso
HR=/root/Osmany
while true
do
 if [ $USER == "root" ]
 then
    . $HR/includes/03_menu.sh
    menu
 else
    dialog --msgbox "Este usuário não tem permissão" 8 40
    exit 0
 fi
done
