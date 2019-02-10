#!/bin/bash
#
# parse_url.sh - Obtém URL's em um site
#
# Site  : linkedin.com/in/mauquinhos
# Autor : @MAUQUINHOS
#
# -----------------------------------------------------
# Este programa recebe como um parametro um site e baixa sua index, e após
# algumas etapas e passagens por filtros, retorna as URL's 
# obtidas de dentro do link
#
# Exemplo de como utilizar:
#
#   $ ./parse_url.sh google.com.br
#       
#       Site: google.com
#       HTTP_CODE: 301
#       URL's obtidas: 15
#       1 http://maps.google.com.br/maps?hl=pt-BR
#       1 http://news.google.com.br/nwshp?hl=pt-BR
#       1 https://accounts.google.com/ServiceLogin?hl=pt-BR
#       ...
#       #####################
#       Resolvendo URL's encontradas:116
#        accounts.google.com	:172.217.28.237 
#        accounts.google.com	:mail 
#       ...
#
# -----------------------------------------------------
#
# Verifica a URL que foi obtida como paramentro($1) e se,
# os parametros existem para continuar o programa
# Caso não exista informa o modo  correto de uso.
#   Exemplo: https://google.com ~> google.com 
if [ "$1" == "" ];
then 

    clear
    
    echo -e "\n Exemplo de como utilizar:\n\t./parse_url.sh meusite.com.br\n"
    
    exit 1
    
fi
#
# Formata a URL com letras minúsculas para evitar erros, 
# remove http's e www's caso existam e salva na variável  $url_limpa.

clear

REMOVE_HTTP(){
    
    url_limpa=$(echo $1 | tr '[A-Z]' '[a-z]' | sed 's~http[s]*://~~g' | sed 's/www.//' |  cut -d "/" -f1)

}

REMOVE_HTTP $1

NOME_DO_ARQUIVO_GERADO=$(echo $url_limpa | cut -d'.' -f1) # Guarda o domínio para salvar o arquivo

echo "PARSING NO SITE: $url_limpa"
#
#
# Obtém o cabeçalho do SITE e armazena o código HTTP_CODE na variavel $code_erro
#
code_erro=$(curl --silent --head --write-out '%{http_code}' $url_limpa | head -n1 | cut -d' ' -f2-6)

echo "      HTTP_CODE: $code_erro" 

code_erro=$(echo "$code_erro" | cut -d' ' -f1) 
#
#
if [ "$code_erro" -ge "400" ]; # Verifica se o código é menor que 400 se for maior continua...
then

    echo "         STATUS: SEM SUCESSO"

else

    echo "         STATUS: INICIANDO DOWNLOAD"
    wget -q -O $NOME_DO_ARQUIVO_GERADO $url_limpa # Baixando o site

    echo "                 LINKS COM HTTP[s]"
    grep -Eo '(http|https)://[a-zA-Z0-9./?=_-]*' $NOME_DO_ARQUIVO_GERADO > temporario

    echo "                 LINKS COM IP[s]"
    grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' $NOME_DO_ARQUIVO_GERADO >> temporario

    echo "                 LINKS COM IP[s]:PORTAS"
    grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\:[0-9]\{1,5\}' $NOME_DO_ARQUIVO_GERADO >> temporario

    echo "                 $(cat temporario | wc -l) URL[s] NO TOTAL"

    echo "                 $(cat temporario | sort -u | wc -l) URL[s] FILTRADAS"

    echo "OBTENDO URL[s] E EXTRAINDO IP[s]: "

    cat temporario | sort -u > parse.tmp

    rm temporario

    for URL in $(cat parse.tmp); do

        REMOVE_HTTP $URL

        host $url_limpa | grep -w "has\|NXDOMAIN\|mail" | sed 's/Host //' | sed 's/has address //' | sed 's/has IPv6 address //' >> temporario
    
    done

    echo "==============================================="
    
    cat temporario  | cut -d" " -f1-2 | sort -u | grep -v "mail"
    
    echo "==============================================="
    
    mv temporario  "$NOME_DO_ARQUIVO_GERADO"
    rm parse.tmp

fi
