#!/bin/bash
#
# Execute o arquivo para inserir usuarios na base de dados
#
DB_USUARIO=$(read -p "Digite o usuario do DB: ")
DB_SENHA=$(read -p "Digite a senha: ")
DB_BASE=nfc
if [ ${#DB_USUARIO} = 0 ] || [ ${#DB_SENHA} = 0 ] || [ ${#DB_BASE} = 0 ]; 
then
	read -p "Faltam adicionar informacoes da Base como USUARIO, SENHA OU BASE"
	exit 1
else
	LOGIN="sudo mysql -u$DB_USUARIO -p$DB_SENHA $DB_BASE"
	USER_ra=$(read -p "Insira um RA: ")
	USER_status=$(read -p "Escolha, uma opcao( ALUNO | FUNCIONARIO | OUTROS ): ")
	USER_img=$(read -p "Insira uma URL para imagem: ")
	USER_curso=$(read -p "Escolha, uma opcao( SEGURANCA | ADS | JOGOS | EAD ): ")
	USER_cpf=$(read -p "CPF: ")
	USER_nome=$(read -p "NOME: ")
	USER_lastname=$(read -p "SOBRENOME")
	USER_timestamp=`date "+%Y%m%d-%H%M%S"`
	USER_comando=$(read -p "Escolha uma opcao( ENTRADA | SAIDA ): ")
	USER_card=$(read -p "ID do cartao: ")
	USER_passwd=$(read -p "Digite a senha: ")
	echo "INSERT INTO profile(ra_user,status_profile,img_profile,curso_profile) VALUES('$USER_ra','$USER_status','$USER_img','$USER_curso');
	INSERT INTO users(id_users,cpf_users,profile_ra_user,nome_users,lastname_users,add_users) VALUES(null,'$USER_cpf','$USER_ra','$USER_nome','$USER_lastname','$USER_timestamp');
	INSERT INTO logs(users_id_users,users_cpf_users,users_logs,funcao_logs) VALUES(last_insert_id(),'$USER_cpf','$USER_timestamp','$USER_comando');
	INSERT INTO cards(id_cards,users_id_users,users_cpf_users,passwd_users) VALUES('$USER_card',last_insert_id(),'$USER_cpf','$USER_passwd');" | $LOGIN;
	
fi
