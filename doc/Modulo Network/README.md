
<p align="center">
  <img src="img/capa.png" width = "200" />
</p>


<h1 align="center">Modulo de Network
</h1>

<h3 align="center">
Desenvolvimento de um Módulo de Comunicação em Rede entre FPGA e ESP8266 12E utilizando UART
<h3>

<div align="justify"> 
<h2>Descrição do Projeto</h2>


</div>

![-----------------------------------------------------](img/len.png)

<h2> Autor <br></h2>
<uL>
  <li><a href="https://github.com/TAlmeida003">Thiago Neri dos Santos Almeida</a></li>
  <li>Engenharia de Computação — UEFS</li>
</ul>

![-----------------------------------------------------](img/len.png)

<h2> Orientador <br></h2>
<ul>
      <li>Dr. Anfranserai Morais Dias</li>
      <li>Departamento de Tecnologia (DTEC) — UEFS</li>
</ul>

![-----------------------------------------------------](img/len.png)

<h1 align="center"> Sumário </h1>
<div id="sumario">
  <ul>
        <li><a href="#esp"> ESP8266 12e </a></li>
        <li><a href="#referencias"> Referências </a></li>
  </ul>	
</div>

![-----------------------------------------------------](img/len.png)


<div align="justify"> 
<div id="esp"> 
<h2>ESP8266 12e</h2>

<h3> Comandos de Controle</h3>

O ESP8266 12e se comunica com a FPGA através de comandos AT, que são comandos de controle que permitem a configuração do módulo. Os comandos AT são enviados pela FPGA para o ESP através da comunicação UART. Por default, o ESP opera a uma taxa de 115200 bps.

Comandos basicos:


<div align="justify"> 
|comando             |descrição| resposta|
|--------------------|---------|---------|
|AT|Teste de comunicação|OK|
|AT+RST|Reinicia o módulo.|OK|
|AT+GSLP=\<time>|Coloca o módulo em modo de baixo consumo de energia por um tempo especificado.|\<time> OK|
AT+RESTORE|Restaura as configurações de fábrica.|OK|
|AT+UART_CUR=\<baud>,\<databits>,\<stopbits>,\<parity>,\<flow control>|Configura a UART.|OK|
|AT+UART_DEF=\<baud>,\<databits>,\<stopbits>,\<parity>,\<flow control>|Configura a UART de forma permanente.|OK|

</div>

>  O comando AT+UART_CUR=115200,8,1,0,3 configura a UART para 115200 bps, 8 bits de dados, 1 bit de parada, sem paridade e com controle de fluxo RTS/CTS.

Comandos wifi:

<div align="justify"> 

|comando|descrição| resposta|
|-------------------|---------|---------|
|AT+CWMODE=\<mode>|Configura o modo de operação do módulo.|OK|
|AT+CWJAP=\<ssid>,\<password>|Conecta o módulo a uma rede Wi-Fi.|OK ou ERRO|
|AT+CWLAP|Lista as redes Wi-Fi disponíveis.|OK|
|AT+CWQAP|Desconecta o módulo da rede Wi-Fi.|OK|
|AT+CWAUTOCONN=\<enable>|Habilita/desabilita a conexão automática à rede Wi-Fi.|OK|

</div>

> O comando AT+CWMODE=3 configura o módulo para operar em modo AP e STA.

> O comando AT+CWJAP="ssid","password" conecta o módulo a uma rede Wi-Fi com SSID e senha especificados.

Comandos TCP/IP:

<div align="justify"> 

|comando|descrição| resposta|
|-------------------|---------|---------|
|AT+CIPSTATUS| Retorna o status da conexão TCP/IP.|STATUS:\<status>|
|AT+CIPSTART=\<type>,\<addr>,\<port>|Estabelece uma conexão TCP/IP.|CONNECT ou ERRO|
|AT+CIPSSLSIZE=\<size>|Configura o tamanho do buffer SSL.|OK|
|AT+CIPSEND=\<length>|Envia dados pela conexão TCP/IP.|OK ou ERRO|
|AT+CIPCLOSE|Fecha a conexão TCP/IP.|CLOSED|
|+IPD|Recebe dados pela conexão TCP/IP.|+IPD,\<length>:\<data>|
|AT+CIPRECVMODE=\<mode>|Configura o modo de recepção de dados.|OK|
|AT+CIPRECVDATA=\<length>|Recebe dados no modo manual.|OK|

</div>

> Ao usar AT+CIPSEND espera-se que o módulo responda com o caractere >, indicando que o módulo está pronto para receber os dados a serem enviados.

> O comando AT+CIPRECVMODE=0 configura o módulo para receber dados de forma automática e AT+CIPRECVMODE = 1 configura o módulo para receber dados manualmente.
</div>
</div>

![-----------------------------------------------------](img/len.png)

<div align="justify"> 
<div id="referencias"> 
<h2>Referências</h2>

> Espressif. **ESP8266 AT Instruction Set**. Disponível em:
<https://www.espressif.com/sites/default/files/documentation/4a-esp8266_at_instruction_set_en.pdf>
Acesso em: 16 de Dezembro de 2024.

</div>
</div>
