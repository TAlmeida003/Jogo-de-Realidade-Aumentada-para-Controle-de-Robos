
<p align="center">
  <img src="img/capa.png" width = "225" />
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
      <li><a href="#uart"> UART </a></li>
        <ul>
          <li><a href="#baud"> Baud Rate </a></li>
          <li><a href="#conexao"> Sinais de Conexão </a></li>
          <li><a href="#flow control"> Controle de Fluxo </a></li>
          <li><a href="#rx"> Receptor UART </a></li>
          <li><a href="#tx"> Transmissor UART </a></li>
        </ul>
      <li><a href="#esp"> ESP8266 12e </a></li>
        <ul>
          <li><a href="#comand"> Comandos de Controle </a></li>
        </ul>
      <li><a href="#referencias"> Referências </a></li>
  </ul>	
</div>

![-----------------------------------------------------](img/len.png)


<div align="justify">
<div id="uart">
<h2>UART</h2>

Um receptor e transmissor assíncrono universal (em inglês, *Universal Asynchronous Receiver and Transmitter*), com a sigla **UART**, 
é um circuito utilizado para enviar dados paralelos por meio de uma linha serial, onde os bits são transmitidos sequencialmente, um de cada vez, formando uma fila [PEDRONI, 2008]. Essa comunicação é considerada **assíncrona**, pois não exige o sincronismo entre os relógios do receptor e do transmissor. Cada caractere transmitido carrega seus próprios sinais de sincronismo [EPUSP, 2015].

A comunicação UART é **full-duplex**, ou seja, permite a transmissão e recepção de dados simultaneamente. Os dados são enviados do bit **LSB** (Least Significant Bit) para o **MSB** (Most Significant Bit). A linha serial é **1** quando está ociosa. A transmissão começa com um **bit de início**, que é **0**, seguido pelos **bits de dados** e, opcionalmente, um **bit de paridade**. A transmissão termina com **bits de parada**, que são sempre **1** [PEDRONI, 2008]. 

As configurações comuns incluem:
- **Número de bits de dados**: 6, 7 ou 8 bits.
- **Número de bits de parada**: 1, 1,5 ou 2 bits.
- **Paridade**: Opcional.

A configuração padrão utilizada é de **8 bits de dados**, sem paridade, e **1 bit de parada**.

Abaixo, é apresentada uma figura que ilustra a estrutura de um quadro de dados UART.


<p align="center">
  <img src="img/frameUART.png" width = "600" />
</p>
<p align="center">
<strong> Figura X: Estrutura de um quadro de dados UART</strong>
</p>

<div id="baud">
<h3>Baud Rate</h3>

Para a comunicação entre a FPGA e o ESP8266 12e, é necessário que ambos os dispositivos usem a mesma taxa de transmissão de dados, conhecida como Baud Rate. Esta taxa é a quantidade de bits transmitidos por segundo (bps) e pode ter valores como 9 600 bps, 115 200 bps, 921 600 bps, entre outros.

No projeto, foi utilizada a taxa de 115 200 bps, que é o padrão do ESP8266. Para configurar a taxa na FPGA, é necessário calcular o divisor de frequência do clock do módulo UART usando a fórmula:

<p align="center">
  <img src="img/divA.png" width = "300" />
</p>

Onde:

<p align="center">
  <img src="img/divB.png" width = "300" />
</p>

Essa configuração resulta em uma margem de erro de apenas **0,004%**, que é aceitável para a comunicação serial.

</div>

<div id='conexao'>
<h3>Sinais de Conexão</h3>

Na comunicação UART, é utilizada a norma EIA-RS-232C como referência para a conexão entre dispositivos, garantindo que fabricantes diferentes possam seguir uma interface comum [EPUSP, 2015]. Os sinais utilizados no projeto são descritos a seguir:

<ul>
  <li><strong>Transmissão de Dados (TXD - Transmit Data):</strong> Transmite dados da FPGA para o ESP8266 12e.</li>
  <li><strong>Recepção de Dados (RXD - Receive Data):</strong> Recebe dados do ESP8266 12e para a FPGA.</li>
  <li><strong>Pronto para Enviar (RTS - Ready to Send):</strong> Indica que a FPGA está pronta para enviar dados.</li>
  <li><strong>Pronto para Receber (CTS - Clear to Send):</strong> Indica que o ESP8266 12e está pronto para receber dados.</li>
  <li><strong>Terra (GND - Ground):</strong> Referência de tensão.</li>
</ul>

A norma EIA-RS-232C também define outros sinais, como DTR, DSR, DCD e RI, que não são utilizados neste projeto. Além disso, embora a norma especifique níveis de tensão próprios para RS-232, o projeto utiliza sinais em níveis lógicos de 0V para o nível lógico 0 e 3,3V para o nível lógico 1, adequados aos dispositivos conectados.


A figura a seguir ilustra a conexão entre a FPGA e o ESP8266 12e usando o padrão UART, mostrando os sinais de conexão utilizados.

<p align="center">
  <img src="img/conexaoUART.png" width = "500" />
</p>
<p align="center">
<strong> Figura X: Conecção entre FPGA e ESP8266 12e usando UART</strong>
</p>

</div>

<div id="flow control">
<h3>Controle de Fluxo</h3>

O controle de fluxo é usado para garantir que os dados sejam transmitidos sem perda de informações. Ele permite que o receptor avise o transmissor quando está pronto para receber dados. Existem dois métodos principais: <strong>XON/XOFF</strong> e <strong>RTS/CTS</strong>. Este projeto utiliza o método RTS/CTS devido à sua eficiência e para evitar ovehreads de dados. 

No método <strong>RTS/CTS</strong>, o transmissor ativa o sinal RTS quando está pronto para enviar dados, indicando que seu buffer de transmissão está vazio. O receptor ativa o sinal CTS quando está pronto para receber dados, indicando que seu buffer de recepção está vazio.

O sinal RTS do transmissor é conectado ao pino CTS do receptor, e o sinal CTS do receptor é conectado ao pino RTS do transmissor.


</div>

<div id="rx">
<h3>Receptor UART</h3>

</div>

<div id="tx">
<h3>Transmissor UART</h3>

</div>

![-----------------------------------------------------](img/len.png)


</div>
</div>

<div align="justify"> 
<div id="esp"> 
<h2>ESP8266 12e</h2>

<div id="comand">
<h3> Comandos de Controle</h3>

O ESP8266 12e se comunica com a FPGA através de comandos AT, que são comandos de controle que permitem a configuração do módulo. Os comandos AT são enviados pela FPGA para o ESP através da comunicação UART. Por default, o ESP opera a uma taxa de 115200 bps.

Comandos basicos:


<div align="center"> 

|comando             |descrição| resposta|
|--------------------|---------|---------|
|AT|Teste de comunicação|OK|
|AT+RST|Reinicia o módulo.|OK|
|AT+GSLP=\<time>|Coloca o módulo em modo de baixo consumo de energia por um tempo especificado.|\<time> OK|
AT+RESTORE|Restaura as configurações de fábrica.|OK|
|AT+UART_CUR=\<baud>,\<databits>,\<stopbits>,\<parity>,\<flow control>|Configura a UART.|OK|
|AT+UART_DEF=\<baud>,\<databits>,\<stopbits>,\<parity>,\<flow control>|Configura a UART de forma permanente.|OK|

</div>

<p align="center">
<strong> Tabela X: Comandos básicos do ESP8266 12e</strong>
</p>

>  O comando AT+UART_CUR=115200,8,1,0,3 configura a UART para 115200 bps, 8 bits de dados, 1 bit de parada, sem paridade e com controle de fluxo RTS/CTS.

Comandos wifi:

<div align="center"> 

|comando|descrição| resposta|
|-------------------|---------|---------|
|AT+CWMODE=\<mode>|Configura o modo de operação do módulo.|OK|
|AT+CWJAP=\<ssid>,\<password>|Conecta o módulo a uma rede Wi-Fi.|OK ou ERRO|
|AT+CWLAP|Lista as redes Wi-Fi disponíveis.|OK|
|AT+CWQAP|Desconecta o módulo da rede Wi-Fi.|OK|
|AT+CWAUTOCONN=\<enable>|Habilita/desabilita a conexão automática à rede Wi-Fi.|OK|

</div>

<p align="center">
<strong> Tabela X: Comandos de configuração Wi-Fi do ESP8266 12e</strong>
</p>

> O comando AT+CWMODE=3 configura o módulo para operar em modo AP e STA.

> O comando AT+CWJAP="ssid","password" conecta o módulo a uma rede Wi-Fi com SSID e senha especificados.

Comandos TCP/IP:

<div align="center"> 

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

<p align="center">
<strong> Tabela X: Comandos de configuração TCP/IP do ESP8266 12e</strong>
</p>

> Ao usar AT+CIPSEND espera-se que o módulo responda com o caractere >, indicando que o módulo está pronto para receber os dados a serem enviados.

> O comando AT+CIPRECVMODE=0 configura o módulo para receber dados de forma automática e AT+CIPRECVMODE = 1 configura o módulo para receber dados manualmente.

</div>

</div>
</div>


![-----------------------------------------------------](img/len.png)

<div align="justify"> 
<div id="referencias"> 
<h2>Referências</h2>

> PEDRONI, Volnei A. FPGA Prototyping by Verilog Examples: Xilinx Spartan-3 Version. 1st ed. Hoboken: Wiley-Interscience, 2008.

> EPUSP — PCS 2021 — Laboratório Digital. **UART**. Versão 2015. Disponível em: <a href="https://www2.pcs.usp.br/~labdig/pdffiles_2015/uart.pdf" target="_blank">https://www2.pcs.usp.br/~labdig/pdffiles_2015/uart.pdf</a>. Acesso em 19 de Dezembro de 2024.

> Espressif. **ESP8266 AT Instruction Set**. Disponível em:
<https://www.espressif.com/sites/default/files/documentation/4a-esp8266_at_instruction_set_en.pdf>.
Acesso em: 16 de Dezembro de 2024.

</div>
</div>
