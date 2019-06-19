# Controle de Acesso

UTILIZANDO RASPBERRY PI TECNOLOGIAS DE BAIXO CUSTO
## Como usar:
```
 - 1 : Baixe o conteúdo, do repositório [NFC_RPI]
 - 2 : Salve-o em uma pasta, NFC_RPI
 - 3 : Dê permissão de execução ao conteúdo do Repositório
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
`@reboot     ~/NFC_RPI/index.sh`
* Lembrando que o arquivo precisa estar em modo de execuação
## O que é?

Controle de acesso é utilizado para controlar ambientes, pessoas e informação. Os arquivos neste repositório, junto com o Hardware descrito no documento, podem ser encontrados na biblioteca da [Fatec São Caetano do Sul](https://www.fatecsaocaetano.edu.br/), estes documentos criam um TCC(`Trabalho de Conclusão de Curso`), em Segurança da Informação.

Este trabalho além de focar em segurança de baixo custo, mostra o quanto estamos sucetiveis a falta da segurança utilizando equipamentos, tecnicamente ultrapassados, mas que continuam em alta. Nos dando a falsa sensação de estarmos seguros.
Ele adiciona uma camada a mais de segurança, na Tecnologia `NFC` e `RFID`, sendo necessário o uso de uma senha como segundo fator de segurança `2FA`.

## Agradecimentos aos Mestres

## Orientador 
Por ter acreditado no projeto, muito obrigado.
* Ismael Moura Parede

### A Banca 
Por avaliarem o projeto e de forma colaborativa apontar nossos erros, para que sempre nos aperfeiçoemos. Obrigado!
* Almir Meira Alves
* Kleber Silva Divino

![WhatsApp Image 2019-06-19 at 12 13 27](https://user-images.githubusercontent.com/47393713/59791694-102ca380-92a9-11e9-9162-c85c197b9783.jpeg)

Um agradecimento em especial a minha Mãe, não pode realizar um sonho, ver um filho formado, mas onde quer que esteja saiba que isso é pra você. Um dia a gente se encontra, deixa meu café pronto!! Te AMO.

