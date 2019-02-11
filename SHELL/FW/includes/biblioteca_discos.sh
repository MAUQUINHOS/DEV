#!/bin/bash
################################
discos(){
 opt_raid=$(dialog --backtitle "MENU > DISCOS" --stdout --menu "Selecione uma opção" 0 0 0 \
 FDISK ' comando fdisk -l' \
 MDADM ' comando mdadm --details md*' \
 SIMULAR 'simula a perda de um disco')
 case $opt_raid in
  FDISK) fdisk_detalhes;;
  MDADM) mdadm_detalhes;;
  SIMULAR) simular_disco;;

  *) menu;;
  esac
}
simular_disco(){
	detalhes_disco=$(mdadm -D /dev/md1 | grep "removed")
	if [ ${#detalhes_disco} -gt 1 ]
	then
	  remover_disco
	  delay 1
	  adicionar_disco
	else
	  falhar_disco
	fi
	disco_md1=$(mdadm -D /dev/md1)
	dialog --msgbox "$disco_md1" 80 80
	discos
	}
falhar_disco(){
	mdadm --manage /dev/md1 --set-faulty /dev/sdc2
	dialog --msgbox "Falha simulada" 40 40
	}
	
remover_disco(){
	mdadm /dev/md1 -r /dev/sdc2
	}
	
adicionar_disco(){
	mdadm /dev/md1 -a /dev/sdc2
	dialog --msgbox "Disco adicionado" 40 40
	}
    
fdisk_detalhes(){
 discos=$(fdisk -l | grep md)
 dialog --msgbox "$discos" 80 80
 discos
}
mdadm_detalhes(){
 discos=$(fdisk -l | grep md | awk '$1=="Disk" { ++count } {print $2 "\n" count $2  } END {}')
 opt_raid=$(dialog --backtitle "MENU > DISCOS > MDADM" --stdout --menu "Selecione uma opção" 0 0 0 $discos | cut -d":" -f1 )
 detalhes=$(mdadm --detail $opt_raid)
 if [ "$?" -eq 0 ]
 then
  dialog --msgbox "$detalhes" 80 80
 fi
 discos
}
