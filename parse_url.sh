#!/bin/bash
#
# parse_url.sh - Obtém URL's em um site
#
# Site  : linkedin.com/in/mauquinhos
# Autor : Marcos R. Pereira
#
# -----------------------------------------------------
# Este programa recebe como um parametro um link, e após
# algumas etapas e passagens por filtros, retorna as URL's 
# obtidas de dentro do link
#
#
# Exemplos:
#
#   $ ./parse_url.sh meusite.com.br
#
#   
#
#
#
#
# -----------------------------------------------------
if [ "$1" == "" ];
then
clear
echo "#############################"
echo "Como utilizar:"
echo -e "\t\t $0 www.site.com"
echo "#############################"
exit 1
fi
site=$(echo $1 | sed 's/https://' | sed 's/http://' | sed 's/www.//' | sed 's/\/\///' | cut -d "/" -f1)
echo "Site: $site"
code=$(curl -o /dev/null --silent --head --write-out '%{http_code}\n' $site)
err(){
string="1xx Informational
100 Continue
101 Switching Protocols
102 Processing (WebDAV)
2xx Success
 200 OK
 201 Created
202 Accepted
203 Non-Authoritative Information
 204 No Content
205 Reset Content
206 Partial Content
207 Multi-Status (WebDAV)
208 Already Reported (WebDAV)
226 IM Used
3xx Redirection
300 Multiple Choices
301 Moved Permanently
302 Found
303 See Other
 304 Not Modified
305 Use Proxy
306 (Unused)
307 Temporary Redirect
308 Permanent Redirect (experimental)
4xx Client Error
 400 Bad Request
 401 Unauthorized
402 Payment Required
 403 Forbidden
 404 Not Found
405 Method Not Allowed
406 Not Acceptable
407 Proxy Authentication Required
408 Request Timeout
 409 Conflict
410 Gone
411 Length Required
412 Precondition Failed
413 Request Entity Too Large
414 Request-URI Too Long
415 Unsupported Media Type
416 Requested Range Not Satisfiable
417 Expectation Failed
418 I'm a teapot (RFC 2324)
420 Enhance Your Calm (Twitter)
422 Unprocessable Entity (WebDAV)
423 Locked (WebDAV)
424 Failed Dependency (WebDAV)
425 Reserved for WebDAV
426 Upgrade Required
428 Precondition Required
429 Too Many Requests
431 Request Header Fields Too Large
444 No Response (Nginx)
449 Retry With (Microsoft)
450 Blocked by Windows Parental Controls (Microsoft)
451 Unavailable For Legal Reasons
499 Client Closed Request (Nginx)
5xx Server Error
 500 Internal Server Error
501 Not Implemented
502 Bad Gateway
503 Service Unavailable
504 Gateway Timeout
505 HTTP Version Not Supported
506 Variant Also Negotiates (Experimental)
507 Insufficient Storage (WebDAV)
508 Loop Detected (WebDAV)
509 Bandwidth Limit Exceeded (Apache)
510 Not Extended
511 Network Authentication Required"
echo -e "$string" | grep "$site"
}

if [ "$code" -ge "400" ];
then
echo "HTTP_CODE: $code" 
err $code
else
echo "HTTP_CODE: $code" 
err $code
wget -q --show-progress --spider --recursive --no-verbose -O temp.html $site > /dev/null
grep -Eo '(http|https)://[a-zA-Z0-9./?=_-]*' temp.html | sort | uniq > temp1
grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' temp.html >> temp1
grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\:[0-9]\{1,5\}' temp.html >> temp1
cat temp1 | sort | uniq > parse.tmp
links=$(cat parse.tmp | sort | uniq | wc -l)
echo "Urls obtidas: $links"
cat parse.tmp | uniq -c
echo "#####################\n"
file=$(echo $site | cut -d "." -f1)
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