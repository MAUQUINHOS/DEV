#!/bin/bash
#funcoes para usuarios
usuarios(){
 opt_usuarios=$(dialog --backtitle "MENU > USUARIOS" --stdout --menu "Selecione uma opcao" 0 0 0 \
 Listar 'listar usuarios do sistema' \
 Buscar 'busca por nome' \
 Adicionar 'adicionar usuario' \
 Remover 'remover usuario')
 case $opt_usuarios in
  Listar) listar_todosusuarios;;
  Buscar) buscar_nomeusuario;;
  Adicionar) adicionar_usuario;;
  Remover) remover_usuario;;
  *) menu; 
 esac
}
adicionar_usuario(){
nome_user=$(dialog --backtitle "USUARIOS > ADICIONAR" --stdout --inputbox "Escolha um nome" -1 -1 )
if [ ${#nome_user} -eq 0 ]
then
 dialog --msgbox "Digite um nome válido." 8 40
 adicionar_usuario
fi
add_user=$(cat /etc/passwd | cut -d: -f1 | grep $nome_user)
 if [ ${#add_user} -eq 0 ]
 then
  useradd -m -d /home/$nome_user -s /bin/bash -c $nome_user $nome_user
  dialog --msgbox "$nome_user, adicionado com sucesso." 8 40 
  read -p 
 else
  dialog --msgbox 'Este cadastro já existe, tente outro.' 8 40
  adicionar_usuario 
 fi
usuarios
}
remover_usuario(){
 nome_user=$(dialog --backtitle "USUARIOS > REMOVER" --stdout --inputbox "Digite o nome a ser removido" -1 -1 )
 del_user=$(grep -iw "50[0-9]" /etc/passwd | cut -d: -f1 | grep $nome_user)
 if [ ${#nome_user} -gt 0 ]
 then
  userdel -r $nome_user
  if [ $? -eq 0 ]
  then
    dialog --msgbox "$nome_user, foi removido do sistema" 8 40
  else
    dialog --msgbox 'Ocorreu algum erro, tente novamente' 8 40
  fi
 else
  dialog --msgbox "Usuario nao encontrado..." 8 40
 fi
usuarios
}
buscar_nomeusuario(){
  buscar_usuario=$(dialog --backtitle "USUARIOS > BUSCA DE USUARIOS" --stdout --nocancel --inputbox "Digite um nome:" -1 -1)
  flag_busca=$(grep -iw "50[0-9]" /etc/passwd | cut -d: -f1 | grep -iw $buscar_usuario)
  if [ ${#flag_busca} -gt 0 ];
  then
   dialog --msgbox "$buscar_usuario, encontrado." 8 40
   usuarios
  else  
   dialog --msgbox "$buscar_usuario, não consta na lista. Tente novamente." 8 40
  fi
usuarios
}
listar_todosusuarios(){
  lista_usuarios=$( grep -iw "50[0-9]" /etc/passwd | cut -d: -f1,3,4 | egrep '*$' -n) 
  dialog --msgbox "$lista_usuarios" 80 60
  usuarios
}



