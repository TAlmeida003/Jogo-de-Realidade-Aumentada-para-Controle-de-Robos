<p align="center">
  <img src="img/logo.png" width = "1000" />
</p>

<h1 align="center">TeleCore64 Console
</h1>

<h3 align="center"> Projeto de Desenvolvimento de uma Interface Portátil para Teleoperação de Robô em Ambiente de 
Realidade Aumentada Usando FPGA
</h3>

![-----------------------------------------------------](img/len.png)

<div align="justify"> 
<h2>Descrição do Projeto</h2>


Este repositório documenta um projeto de iniciação científica, patrocinado pelo **CNPq**, que tem como objetivo desenvolver uma interface portátil de videogame para jogos 2D (console) e controlar um robô utilizando uma **FPGA**. O projeto explora a integração de sistemas embarcados, comunicação serial e protocolos de rede, promovendo uma interação inovadora entre jogos e robótica.  

O projeto é dividido em três etapas principais:  

### 1. Desenvolvimento do Console de Videogame  
- Utilização do processador **Nios II** e de um processador gráfico **CoLenda**.  
- Desenvolvimento da interface de controle do console.  
- Criação da interface de vídeo utilizando **HDMI**.  

### 2. Comunicação entre a FPGA e o Robô  
- Implementação de um **ESP** como intermediário para conectar a FPGA ao robô.  
- Utilização de **UART** para a comunicação entre a FPGA e o ESP.  
- Uso do protocolo **TCP/IP** para a comunicação do ESP com o **ROS (Robot Operating System)**.  

### 3. Integração do Console com o Robô  
- O console envia comandos para o robô enquanto o jogo é jogado.  
- Sincronização entre os dados do jogo e as ações do robô. 


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
        <li><a href="#vg"> Visão Geral do Sistema</a></li>
        <ul>
          <li><a href="#arqGeral">Arquitetura Geral</a></li>
          <li><a href="#arqFPGA">Arquitetura do hardware</a></li>
        </ul>
        <li><a href="#VES"> Descrição dos Equipamentos e Software Utilizados</a></li>
        <ul>
          <li><a href="#FPGA">Kit FPGA DE0-Nano</a></li>
          <li><a href="#GameHat">Game Hat</a></li>
          <li><a href="#Quartus">Quartus Lite</a></li>
          <li><a href="#Eclipse">Eclipse</a></li>
          <li><a href="#ModelSim">ModelSim</a></li>
          <li><a href="#NIOS">NIOS II</a></li>
          <li><a href="#ESP">ESP 8266 12e</a></li>
          <li><a href="#PIO">PIO Core</a></li>
        </ul>
        <li><a href="#pinout"> Pinout </a></li>
        <li><a href="#referencias"> Referências </a></li>
	</ul>	
</div>


<div align="justify">

<div id="vg">

![-----------------------------------------------------](img/len.png)

<h2>Visão Geral do Sistema</h2>

<div id="arqGeral">
<h3>Arquitetura Geral</h3>

A figura a seguir mostra a arquitetura geral do sistema:

<p align="center">
  <img src="img/arqGeral.png" width = "700" />
</p>
<p align="center">
<strong> Figura X: Arquitetura geral do projeto</strong>
</p>

<div id="arqFPGA">

<h3>Arquitetura do hardware</h3>

A figura a seguir mostra a versão simplificada da arquitetura total do sistema já desevolvida:

<p align="center">
  <img src="img/arqTotal.png" width = "700" />
</p>
<p align="center">
<strong> Figura X: Arquitetura total do projeto</strong></p>

</div>

</div>
</div>


<div align="justify"> 
<div id="VES"> 

![-----------------------------------------------------](img/len.png)

<h2>Descrição dos Equipamentos e Software Utilizados</h2>

Nesta seção, serão apresentados os equipamentos e softwares utilizados no desenvolvimento do projeto, incluindo a placa FPGA, o kit de desenvolvimento, o software de programação e simulação, entre outros.

<div id="FPGA">
<h3>Kit FPGA DE0-Nano</h3>

O **Kit FPGA DE0-Nano**, baseado na FPGA **Altera Cyclone IV EP4CE22F17C6N**, é uma plataforma de desenvolvimento ideal para projetos de hardware e sistemas embarcados.
 A FPGA possui 22.320 elementos lógicos, 594 Kbits de memória RAM interna, 66 multiplicadores e 4 PLLs para controle de clock, proporcionando um excelente desempenho e
  flexibilidade. Com 256 pinos disponíveis, o kit é amplamente utilizado em aplicações que exigem processamento eficiente e personalizável, como sistemas embarcados,
  controle industrial e processamento de sinais digitais [Embarcados, 2014]. A imagem a seguir mostra o kit FPGA DE0-Nano e seus principais componentes.

<p align="center">
  <img src="img/deonano.png" width = "600" />
</p>
<p align="center"><strong>Figura 3: Kit FPGA DE0-Nano</strong></p>

</div>

<div id="GameHat">
<h3>Game Hat</h3>

O **Game HAT** é uma placa de expansão projetada para transformar o Raspberry Pi em um console portátil de videogame.
Ele possui uma tela LCD de 3,5 polegadas, botões físicos, um D-pad, além de interfaces para áudio e bateria, proporcionando uma experiência de jogo
completa. A imagem a seguir mostra o Game HAT.

<p align="center">
  <img src="img/gamehat.png" width = "700" />
</p>
<p align="center"><strong>Figura 4: Game HAT</strong></p>

</div>

<div id="Quartus">
<h3>Quartus Lite</h3>

Ferramenta gratuita para design e programação de dispositivos lógicos como FPGAs. Utilizada para desenvolver e transferir a configuração do hardware via USB-Blaster integrado na DE0-Nano.

</div>

<div id="Eclipse">
<h3>Eclipse</h3>

IDE baseado no Eclipse para programação em C/C++ de sistemas embarcados usando o processador NIOS II, facilitando integração e controle de hardware.

</div>

<div id="ModelSim">
<h3>ModelSim</h3>

Simulador de hardware para verificar circuitos digitais antes da implementação. Suporta simulação funcional e temporal, otimizando o design e identificando erros de forma antecipada.

</div>

<div id="NIOS">
<h3>NIOS II</h3>

O **NIOS II** é um processador soft-core da Intel (Altera), projetado para ser usado em FPGAs, como a Cyclone IV. Ele permite personalizar o processador conforme as necessidades do projeto, ajustando dados, caches e outros recursos. Utilizado em sistemas embarcados, o NIOS II realiza tarefas como controle de periféricos e processamento de sinais, sendo programado em C/C++. Com o Quartus e o ambiente Eclipse, ele oferece uma solução flexível e eficiente para controle e processamento de hardware [Embarcados, 2014].

</div>

<div id="ESP">
<h3>ESP 8266 12e</h3>

ESP8266 é um módulo de comunicação Wi-Fi de baixo custo e alto desempenho, ideal para projetos de IoT e automação residencial. Com um microcontrolador integrado, ele suporta protocolos TCP/IP e pode ser controlado por comandos AT, facilitando a integração com outros dispositivos. O ESP8266 12e é uma versão popular do módulo, com 4 MB de memória flash e suporte a Wi-Fi 802.11 b/g/n. Ele é amplamente utilizado em projetos de automação, monitoramento e controle remoto, oferecendo uma solução econômica e eficiente para conectar dispositivos à Internet [Embarcados, 2014].

</div>

<div id="PIO">
<h3>PIO Core</h3>

O  ***Parallel Input/Output Core***, com sigla PIO Core, é um componente de hardware em FPGAs que gerencia entradas e saídas de dados, permitindo que o processador, como o NIOS II, se comunique com dispositivos externos. Ele lê sinais de botões e armazena os dados no modo de entrada, enquanto no modo de saída, envia informações do processador para controlar dispositivos como LEDs. Além disso, o PIO Core pode gerar interrupções para avisar o processador sobre eventos importantes, tornando o gerenciamento de entradas e saídas mais eficiente [Intel, 2024].

</div>

</div>
</div>

<div align="justify"> 
<div id="pinout"> 

![-----------------------------------------------------](img/len.png)

<h2>Pinout</h2>

<div align="center">

| Num Pin | GPIO     |FPGA PIN | Função no Controle |
|---------|----------|---------|--------------------|
| 9       | GPIO_16  | PIN_R12 | HSYNC              |
| 10      | GPIO_17  | PIN_T11 | VSYNC              |
| 14      | GPIO_19  | PIN_R11 | B[2]               |
| 16      | GPIO_111 | PIN_R10 | B[1]               |
| 18      | GPIO_113 | PIN_P9  | B[0]               |
| 20      | GPIO_115 | PIN_N11 | G[2]               |
| 22      | GPIO_117 | PIN_K16 | G[1]               |
| 24      | GPIO_119 | PIN_L15 | G[0]               |
| 26      | GPIO_121 | PIN_P16 | R[2]               |
| 28      | GPIO_123 | PIN_N16 | R[1]               |
| 27      | GPIO_122 | PIN_R14 | R[0]               |

</div>

<p align="center">
<strong> Tabela com a pinagem do VGA</strong></p>

<div align="center">

| PIN | Name PIN | FPGA PIN | Função             |
|-----|----------|----------|--------------------|
| 39  | GPIO_032 | PIN_D12  | Botão Y            |
| 37  | GPIO_030 | PIN_A12  | Botão START        |
| 35  | GPIO_028 | PIN_C11  | Botão A            |
| 33  | GPIO_026 | PIN_E11  | Direcional RIGHT   |
| 31  | GPIO_024 | PIN_C9   | Direcional LEFT    |
| 40  | GPIO_033 | PIN_B12  | Direcional DOWN    |
| 38  | GPIO_031 | PIN_D11  | Direcional UP      |
| 36  | GPIO_029 | PIN_B11  | Botão B            |
| 34  | GPIO_027 | PIN_E10  | Botão TR           |
| 32  | GPIO_025 | PIN_D9   | Botão SELECT       |
| 28  | GPIO_023 | PIN_E9   | Botão TL           |
| 26  | GPIO_021 | PIN_F8   | Botão X            |
| -   | CLOCK_50 | PIN_R8   | CLOCK principal    |
| -   | KEY1     | PIN_E1   | Botão de reset     |

</div>

<p align="center">
<strong> Tabela 10: Pinagem dos botões e analogico</strong></p>

</div>
</div>



<div align="justify"> 
<div id="referencias"> 

![-----------------------------------------------------](img/len.png)
<h2>Referências</h2>

> Embedfire. **Design e verificação do driver de vídeo HDMI**. <https://doc.embedfire.com/fpga/altera/ep4ce10_pro/zh/latest/code/hdmi.html>.
>
> Ti. **PMP10580 DE0-Nano User Manual (Terasic/Altera)**. <https://www.ti.com/lit/ug/tidu737/tidu737.pdf>.
>

</div>
</div>
