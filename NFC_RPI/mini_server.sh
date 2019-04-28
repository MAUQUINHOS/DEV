#!/bin/bash
#####################################################
# Referencia 
# https://stackoverflow.com/questions/15463953/bash-web-server-on-port-80-without-running-as-root-all-the-time
#####################################################
#
# VARIAVEIS
RESPONSE=/tmp/webresp
#
PORTA_WEB=1500
#
# Arquivo temporário
[ -p $RESPONSE ] || mkfifo $RESPONSE
#
while true ; do
#
    ( cat $RESPONSE ) | nc -l -p $PORTA_WEB | (
#
    REQUEST=`while read L && [ " " "<" "$L" ] ; do echo "$L" ; done`
    echo "Request: $REQUEST"
#
    REQ="`echo \"$REQUEST\" | head -n 1`"   
#   REQ= GET /a HTTP/1.1
# Log de acesso
    echo "[ `date '+%Y-%m-%d %H:%M:%S'` ] $REQ" >> http-access.log
# Laco limita qual tipo de entrada
    if [[ $REQ =~ ^GET\ /a[\ \/\#?] ]]; then
        # ...
#		REQ A: GET /a HTTP/1.1
        RESP=$(cat index.html)
        #RESP="<p>You are at A</p><p><a href='/'>Home</a></p>"
    elif [[ $REQ =~ ^GET\ /b[\ \/\#?] ]]; then
        # ...
        RESP="<p>You are at B</p><p><a href='/'>Home</a></p>"
    elif [[ $REQ =~ ^GET\ /c[\ \/\#?] ]]; then
        # ...
        RESP="<p>You are at C</p><p><a href='/'>Home</a></p>"
    else 
#		REQ OUT: GET / HTTP/1.1
        read -r -d '' RESP <<'HTMLDOC'
        <h3>Home</h3>
        <p><a href='/a'> A </a>|<a href='/b'> B </a>|<a href='/c'> C </a></p>
HTMLDOC

    fi

    cat >$RESPONSE <<EOF
HTTP/1.0 200 OK
Cache-Control: private
Content-Type: text/html
Server: bash/2.0
Connection: Close
Content-Length: ${#RESP}

$RESP
EOF
    )
done
