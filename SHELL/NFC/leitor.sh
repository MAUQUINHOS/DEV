
#!/bin/bash
clear;
meu_ID="";
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
EXIBE_TELA(){
        echo "+========= N F C ==========+"
        #dec 
        echo -e "=     ORIGINAL : $meu_ID";
        #dec to hex
        meu_ID=$(printf "%x\n" $meu_ID;)
        #id to upercase 
        meu_ID=$(echo ${meu_ID^^})
        echo -e "      HEX>UPPER: $meu_ID";
        #hex to dec
        meu_ID=$(echo "ibase=16; $meu_ID" | bc) 
        echo -e "      HEX > DEC: $meu_ID";
        echo -e "+==========================+\n"
        meu_ID="";
}
while true;
do
        LER_NFC;
done
