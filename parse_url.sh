#!/bin/bash
#
# parse_url.sh - Obtém URL's em um site
#
# Site  : linkedin.com/in/mauquinhos
# Autor : Marcos R. Pereira
#
# -----------------------------------------------------
# Este programa recebe como um parametro um site e baixa sua index, e após
# algumas etapas e passagens por filtros, retorna as URL's 
# obtidas de dentro do link
#
# Exemplo de como utilizar:
#
#   $ ./parse_url.sh meusite.com.br
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
# Verifica os parametros existem para continuar o programa
# Caso não tenha informa o modo de uso correto
[ "$1" ] && {

    clear
    
    echo -e "Exemplo de como utilizar:\n\t./parse_url.sh meusite.com.br\n"
    
    exit 1
    
    }
#
#
# Verifica a URL que foi obtida como paramentro($1),
# e remove http's e www's caso existam, deixando a $url_limpa.
#   Exemplo: https://google.com ~> google.com
# 
REMOVE_HTTP(){

    echo "$1" | tr '[A-Z]' '[a-z]'

    url_limpa=$(echo $1 | tr '[A-Z]' '[a-z]' | sed 's~http[s]*://~~g' | sed 's/www.//' |  cut -d "/" -f1)
    
    echo "SITE: $url_limpa"

}

CODIGO _ERRO(){

    code_erro=$(curl -o /dev/null --silent --head --write-out '%{http_code}\n' $url_limpa)
    
    cat http_codes |  grep "$url_limpa"

}

if [ "$code_erro" -ge "400" ];
then
echo "HTTP_CODE: $code_erro" 
err $code_erro
else
echo "HTTP_CODE: $code_erro" 
err $code_erro
wget -q --show-progress --spider --recursive --no-verbose -O temp.html $url_limpa > /dev/null
grep -Eo '(http|https)://[a-zA-Z0-9./?=_-]*' temp.html | sort | uniq > temp1
grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' temp.html >> temp1
grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\:[0-9]\{1,5\}' temp.html >> temp1
cat temp1 | sort | uniq > parse.tmp
links=$(cat parse.tmp | sort | uniq | wc -l)
echo "Urls obtidas: $links"
cat parse.tmp | uniq -c
echo -e "#####################\n"
file=$(echo $url_limpa | cut -d "." -f1)
for host in $(cat parse.tmp | cut -d ':' -f2 | sed 's/www.//' | sed 's/\/\///' | cut -d '/' -f1 | sort -u ); do
host $host  | grep -w "has\|NXDOMAIN\|mail" | sed 's/Host //' | sed 's/has address //' | sed 's/has IPv6 address //' >>  "$file"
done
links=$(cat $file | wc -l)
echo "Resolvendo URL's encontradas:"$links 
for host in $(cat "$file" | sort -u | cut -d " " -f 2,1  --output-delimiter='\t:'); do
echo -e "$host" | tr '\n' ' '
echo ""
done
rm temp.html temp1 parse.tmp
fi