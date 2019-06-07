#! /usr/bin/python
# -*- coding: utf-8 -*-
import SimpleHTTPServer
import SocketServer

PORT = 80

class MyHTTPHandler(SimpleHTTPServer.SimpleHTTPRequestHandler):
#Pasta onde vai ficar os arquivos
web="~/"
    web_dir = os.path.join(os.path.dirname(__file__), web)
    os.chdir(web_dir)

    buffer = 1
    log_file = open('logfile.txt', 'w', buffer)
    def log_message(self, format, *args):
        self.log_file.write("%s - - [%s] %s\n" %(self.client_address[0], self.log_date_time_string(), format%args))
        src_str = ("%s - - [%s] %s\n" %(self.client_address[0], self.log_date_time_string(), format%args))
        sub_index = src_str.find('cadastro')
        if sub_index > 0:
            print src_str

Handler = MyHTTPHandler

httpd = SocketServer.TCPServer(("", PORT), Handler)

print "serving at port", PORT

httpd.serve_forever()
