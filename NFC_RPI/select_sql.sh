#!/bin/bash
EVENTO_NFC=$(ls -l  /dev/input/by-{path,id}/ | grep RFID | cut -d"/" -f2)
EVENTO_NUMPAD=$(ls -l  /dev/input/by-{path,id}/ | grep "event-kbd" | grep -v "$EVENTO_NFC" | cut -d"/" -f2 | sort -u)
# Debug Local
echo -e "5- QUERY NO SQL"
#
if [[ -z "$1" ]]
then
	echo "Erro no envio dos parametros: ~# $0 name pass db info"
else
#	sql=$(echo "SELECT nome_users FROM users, cards WHERE id_cards='$4'" | sudo mysql -u$1 -p$2 $3;)
	sql=$(echo "SELECT nome_users FROM users, cards WHERE id_users=(SELECT users_id_users FROM cards WHERE id_cards='$4')" | sudo mysql -u$1 -p$2 $3;)
#	echo -e "SQL: $sql \nSQL1: L$sql1"
	if [ -z "${sql}" ]; then
		python alertas.py r 0.05 4
		status="outros"
		img="img/sem_cadastro.png"
		info="Nome do aluno"
		datas=`date "+%H:%M:%S - %d/%m/%Y"`
		sumary="TAG: <b>$4</b> Sem cadastro na base de dados."
		LOG="<tr data-status='$status' class='alert alert-danger' role='alert'><td><div class='media'><a href='#' class='pull-left'><img src='$img' class='media-photo'></a><div class='media-body'><h4 class='title'>$info</h4><span class='media-meta pull-right'>$datas</span></div><p class='summary'>$sumary</p></div></td></tr>\n"
		echo "<!-- $4 Não cadastrado --> $LOG" >> web/log_file.tmp
	else
#		m_var=$(echo "SELECT nome_users,lastname_users,profile_ra_user,status_profile,img_profile,curso_profile FROM users,profile,cards WHERE id_cards='$4'" | sudo mysql -u$1 -p$2 $3;)
		m_var=$(echo "SELECT nome_users,lastname_users,profile_ra_user,status_profile,img_profile,curso_profile, passwd_users FROM users,profile,cards where id_users=(select users_id_users from cards where id_cards='$4')" | sudo mysql -u$1 -p$2 $3;)
		python alertas.py g 0.05 1
# CHAMA TECLADO NUMPAD E PEGA SENHA
		echo -e "6- ATIVA NUMPAD, ESPERA SENHA"
		SENHA=$(python read_numpad.py $EVENTO_NUMPAD)
		counta=7
		ARRAY=()
		for i in ${m_var[@]}; 
		do 
			#echo $conta
			ARRAY+=($i)
#			echo "array $conta : ${ARRAY[$conta]}"
			conta=$(($conta+1))
		done
#		echo "AR0: ${ARRAY[0]}"
#		echo "AR1: ${ARRAY[1]}"
#		echo "AR2: ${ARRAY[2]}"
#		echo "AR3: ${ARRAY[3]}"
#		echo "AR4: ${ARRAY[4]}"
#		echo "AR5: ${ARRAY[5]}"
#		echo "AR6: ${ARRAY[6]}"
#		echo "AR7: ${ARRAY[7]}"
#		echo "AR8: ${ARRAY[8]}"
#		echo "AR9: ${ARRAY[9]}"
#		echo "AR10: ${ARRAY[10]}"
#		echo "AR11: ${ARRAY[11]}"
#		echo "AR12: ${ARRAY[12]}"
#		echo "AR13: ${ARRAY[13]}"# SENHA
#		echo "AR14: ${ARRAY[14]}"
#		echo "AR15: ${ARRAY[15]}"
#		echo "AR16: ${ARRAY[16]}"
#		echo "NUMPAD: $SENHA"
#		echo "BASEDB: ${ARRAY[13]}"
#exit 1;
		echo -e "6.1 - VALIDA SENHA\n"
		if [ "$SENHA" -eq ${ARRAY[13]} ]; then
			python alertas.py g 0.05 1
			status="${ARRAY[10]}"
			img="${ARRAY[11]}"
			info="<b>${ARRAY[7]}</b> ${ARRAY[8]}"
			datas=`date "+%H:%M:%S - %d/%m/%Y"`
			sumary="<p>RA: ${ARRAY[9]} <br /> Curso:<b>${ARRAY[12]}</b></p>"
			LOG="<!-- $4 -->\n<tr data-status='$status'><td><div class='media'><a href='#' class='pull-left'><img src='$img' class='media-photo'></a><div class='media-body'><h4 class='title'>$info</h4><span class='media-meta pull-right'>$datas</span></div><p class='summary'>$sumary</p></div></td></tr>\n"
			echo $LOG >> web/log_file.tmp
		else
			python alertas.py r 0.05 4 
			status="outros"
			img="img/sem_cadastro.png"
			info="Nome do aluno"
			datas=`date "+%H:%M:%S - %d/%m/%Y"`
			sumary="TAG: <b>LOG: </b> SENHA ERRADA."
			LOG="<tr data-status='$status' class='alert alert-danger' role='alert'><td><div class='media'><a href='#' class='pull-left'><img src='$img' class='media-photo'></a><div class='media-body'><h4 class='title'>$info</h4><span class='media-meta pull-right'>$datas</span></div><p class='summary'>$sumary</p></div></td></tr>\n"
			echo "<!-- $4 Não cadastrado --> $LOG" >> web/log_file.tmp
			
		fi
		
	fi
fi
FILE="web/temp.tmp"
echo -e "7 - GRAVA LOG\n"   
if [ -f $FILE ]; then
	tail -n 20 web/log_file.tmp | tac > $FILE 
	LINHAS=$(cat $FILE | wc -l); 
	if [ $LINHAS -gt "100" ]; then
		rm web/log_file.tmp 
	fi
else
	echo "Arquivo criado temp.tmp"
	echo "" > web/temp.tmp
fi
