## CHANGELOG 19/06/19
# Controle de Acesso V1.0

UTILIZANDO RASPBERRY PI TECNOLOGIAS DE BAIXO CUSTO
## Como usar:
```
 - 1 : Baixe o conteúdo, do repositório [DEV]
 - 2 : Acesse a pasta, NFC_RPI [~# cd NFC_RPI]
 - 3 : Dê permissão de execução ao conteúdo da pasta [~#chmod -R 777 *]
 - 4 : Instale o arquivo .sql da pasta INSTALL, para a obter base de dados
```
### Exemplo
```
~# chmod 777 -R ~/NFC_RPI/
~# cd ~/NFC_RPI/
```

## Execute 
```
./inicio.sh
```
### Adicionais
```
~# crontab -e
Select an editor.  To change later, run 'select-editor'.
  1. /bin/nano        <---- easiest

Choose 1-3 [1]: 1
```
### Adicione ao final, para iniciar no Reboot
`@reboot     ~/NFC_RPI/inicio.sh`

### Base de Dados
* Lembrando que o MySql precisa estar em modo de execuação
```
 - 1 : Verifique se sua máquina contêm MySQL
 - 2 : Faça o login, e instale o arquivo .sql que está na pasta INSTALL
```

## O que é?

 Controle de acesso é utilizado para controlar ambiente, pessoas e informações, somente permitindo o acesso, a quem for autorizado. Os arquivos deste repositório em conjunto com o Hardware descrito no documento `Controle de Acesso Utilizando Raspberry PI e Tecnologias de Baixo Custo`, foram publicados na Biblioteca da [Fatec São Caetano do Sul](https://www.fatecsaocaetano.edu.br/), estes documentos criam um TCC(`Trabalho de Conclusão de Curso`), em Segurança da Informação.
 
 Este projeto além de focar em Segurança Fisíca com Baixo Custo, mostra o quanto estamos sucetíveis a falta da segurança, quando utilizamos equipamentos tecnicamente ultrapassados, mas que continuam em alta demanda no mercado. Sem sabermos disto, temos a falsa sensação de estarmos seguros.
 
 Por fim, este equipamento adiciona uma senha, gera logs, cria um ambiente de gerenciamento fortificando a Tecnologia em questão `NFC` e `RFID`, segue um modelo simplificado de `2FA` (Duplo Fator de Autenticação). Vale ressaltar que por mais que se invista em técnologia e treinamento, sempre haverá um elo fraco, ocasionando a vulnerabilidade.

### SCHEMATIC
![controle de acesso2](https://user-images.githubusercontent.com/47393713/59801878-de263c00-92be-11e9-9aa7-92f20c7daa7a.png)

## Agradecimentos aos Mestres

### Orientador 
Por ter acreditado no projeto, muito obrigado.
* Ismael Moura Parede

### A Banca 
Por avaliarem o projeto e de forma colaborativa apontar nossos erros, para que sempre nos aperfeiçoemos. Obrigado!
* Almir Meira Alves
* Kleber Silva Divino

![WhatsApp Image 2019-06-19 at 12 13 27](https://user-images.githubusercontent.com/47393713/59791694-102ca380-92a9-11e9-9162-c85c197b9783.jpeg)

Um agradecimento em especial a minha Mãe, não pode realizar um sonho, ver um filho formado, mas onde quer que esteja saiba que isso é pra você. Um dia a gente se encontra, deixa meu café pronto!! Te AMO.

