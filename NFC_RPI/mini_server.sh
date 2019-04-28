#!/bin/bash

RESPONSE=/tmp/webresp
[ -p $RESPONSE ] || mkfifo $RESPONSE

while true ; do
    ( cat $RESPONSE ) | nc -l -p 8080 | (
    REQUEST=`while read L && [ " " "<" "$L" ] ; do echo "$L" ; done`
    REQ="`echo \"$REQUEST\" | head -n 1`"

    echo "[ `date '+%Y-%m-%d %H:%M:%S'` ] $REQ" >> http-access.log

    if [[ $REQ =~ ^GET\ /a[\ \/\#?] ]]; then
        # ...
        RESP=$(cat index.html)
        #RESP="<p>You are at A</p><p><a href='/'>Home</a></p>"
    elif [[ $REQ =~ ^GET\ /b[\ \/\#?] ]]; then
        # ...
        RESP="<p>You are at B</p><p><a href='/'>Home</a></p>"
    elif [[ $REQ =~ ^GET\ /c[\ \/\#?] ]]; then
        # ...
        RESP="<p>You are at C</p><p><a href='/'>Home</a></p>"
    else 
        read -r -d '' RESP <<'HTMLDOC'
        <h3>Home</h3>
        <p><a href='/a'>A</a></p>
        <p><a href='/b'>B</a></p>
        <p><a href='/c'>C</a></p>
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
#Server
#https://stackoverflow.com/questions/15463953/bash-web-server-on-port-80-without-running-as-root-all-the-time
