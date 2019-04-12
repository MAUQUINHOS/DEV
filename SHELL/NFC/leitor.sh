#!/bin/bash
clear;
meu_ID="";

SENHA_SQL(){
        unset SENHA;
        echo -e "Digite e senha do DB: "
        while IFS= read -r -s -n1 pass; do
          if [[ -z $pass ]]; then
             echo
             break
          else
             echo -n '*'
             SENHA+=$pass
          fi
        done
        echo $SENHA &>/dev/null 
}

INFO(){
 read -p "$1" meu_ID; &>/dev/null
}

LER_NFC(){
#Efetua a leitura do TAG nfc
        INFO "Insira uma TAG: " 

        if [ "$meu_ID" == "s" ];
        then
                INFO "Bye Bye!!";
                clear;
                exit 1;
        fi

#Valida input verifica se os caracteres são > "11" ex:"1937875174\n" 11chars
        [ ${#meu_ID} -ge 11 ] && echo "TAG invalida!" || EXIBE_TELA;
}

QUERY_SQL(){
if [ -z "$SENHA" ];
then
        echo "FALTA SENHA SQL!!";
        SENHA_SQL;
else
mysql -uroot -p$SENHA <<EOF
use nfc;
select nome_users from users where id_users=$meu_ID;
EOF
fi
        #select * from users;
        #INSERT INTO `nfc`.`users` (`id_users`, `cpf_users`, `profile_ra_user`, `nome_users`, `lastname_users`, `add_users`) VALUES ('1', '333333333333', '136328', 'marcos', 'r pereira', '00:00:00');
        #select * from profile;
select nome_users from users where id_users=$meu_ID;
EOF)
echo "MINHA VAR: $my_VAR"
fi
        #select * from users;
        #INSERT INTO `nfc`.`users` (`id_users`, `cpf_users`, `profile_ra_user`, `nome_users`, `lastname_users`, `add_users`) VALUES ('1', '333333333333', '136328', 'marcos', 'r pereira', '00:00:00');
        #select * from profile;
}

EXIBE_TELA(){
        echo "+========= N F C ==========+"
        echo -e '\033[31m'
        #dec 
        echo -e "    ORIGINAL : $meu_ID";
        #dec to hex
        meu_ID=$(printf "%x\n" $meu_ID;)
        #id to upercase 
        meu_ID=$(echo ${meu_ID^^})
        echo -e "    HEX>UPPER: $meu_ID";
        #hex to dec
        meu_ID=$(echo "ibase=16; $meu_ID" | bc) 
        echo -e "    HEX > DEC: $meu_ID";
        echo -e '\033[m'
        echo -e "+==========================+\n"
        meu_ID="";
        QUERY_SQL;
}

SENHA_SQL;

while true;
do
        LER_NFC;
done
