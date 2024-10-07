

<h1 align="center">Modulo de I/O
</h1>

<h3 align="center"> Projeto de Desenvolvimento de uma Interface de Entrada e Saída para Controle de Videogame Usando FPGA
</h3>

![-----------------------------------------------------](img/len.png)

<div align="justify"> 
<h2>Descrição do Projeto</h2>

O gerenciamento de dispositivos de Entrada/Saída, com a sigla E/S (em inglês: *Input/Output*, I/O), sempre foi um grande
desafio na área de sistemas embarcados. Isso se deve tanto à natureza assíncrona dos dados quanto à diferença de velocidade 
entre o processador e os dispositivos periféricos, o que pode afetar significativamente o desempenho da CPU. Para fornecer uma
interface simples e confiável ao usuário e às aplicações, utiliza-se uma estrutura de camadas de hardware (HW) e software 
(SW). Essa organização em camadas permite ocultar os detalhes específicos dos periféricos para as camadas superiores
[ANDREW S. TANENBAUM, 2003]. A Figura 1 ilustra essa arquitetura de camadas entre o software e o hardware.

<p align="center">
  <img src="img/camadas.png" width = "600" />
</p>
<p align="center"><strong>Figura 1: Arquitetura de camadas entre o software e o hardware</strong></p>

Neste projeto, o foco está no gerenciamento dos periféricos de um controle de videogame.
Desenvolveu-se um **módulo de I/O** de 64 *bits* em *Verilog*, uma linguagem de descrição de hardware, 
implementado em uma matriz de portas programáveis (em inglês: *Field-Programmable Gate Array*, com a sigla FPGA) com processador **NIOS II**, acompanhado de uma biblioteca em linguagem C para facilitar o acesso ao hardware. 
O principal objetivo desse módulo é realizar a leitura dos dados dos botões e do joystick. 
Ele é responsável por capturar e armazenar as informações provenientes dos periféricos e transmiti-las
à CPU sob demanda ou via interrupção. Além disso, o módulo processa as configurações solicitadas pela CPU por meio de software. 
Este projeto detalhará o funcionamento do módulo tanto no nível de hardware quanto no nível de software, 
abordando sua arquitetura, interfaces e como os desenvolvedores podem integrá-lo em suas aplicações. Pra se ter uma visão geral do sistema,
a Figura 2 apresenta o diagrama geral do projeto.

<p align="center">
  <img src="img/geral.png" width = "800" />
</p>
<p align="center"><strong>Figura 2: Visão geral do sistema</strong></p>

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
        <li><a href="#VES"> Descrição dos Equipamentos e Software Utilizados </a></li>
        <li><a href="#FH"> Funcinalidades</a></li>
        <li><a href="#DH"> Arquitetura</a></li>
        <li><a href="#D"> Bibliotecas </a></li>
        <li><a href="#AP"> Análise de Pinout </a></li>
        <li><a href="#OCF"> Organização do Código Fonte </a></li>
        <li><a href="#TR">Testes Realizados </a></li>
        <li><a href="#EP"> Execução do Projeto </a></li>
        <li><a href="#referencias"> Referências </a></li>
	</ul>	
</div>


![-----------------------------------------------------](img/len.png)
<div align="justify"> 
<div id="VES"> 

<h2>Descrição dos Equipamentos e Software Utilizados</h2>

<h3>Kit FPGA DE0-Nano</h3>

O **Kit FPGA DE0-Nano**, baseado na FPGA **Altera Cyclone IV EP4CE22F17C6N**, é uma plataforma de desenvolvimento ideal para projetos de hardware e sistemas embarcados. A FPGA possui 22.320 elementos lógicos, 594 Kbits de memória RAM interna, 66 multiplicadores e 4 PLLs para controle de clock, proporcionando um excelente desempenho e flexibilidade. Com 256 pinos disponíveis, o kit é amplamente utilizado em aplicações que exigem processamento eficiente e personalizável, como sistemas embarcados, controle industrial e processamento de sinais digitais. A imagem a seguir mostra o kit FPGA DE0-Nano e seus principais componentes.

<p align="center">
  <img src="img/deonano.png" width = "400" />
</p>
<p align="center"><strong>Figura 3: Kit FPGA DE0-Nano</strong></p>

<h3>Game Hat</h3>

O **Game HAT** é uma placa de expansão projetada para transformar o Raspberry Pi em um console portátil de videogame. Ele possui uma tela LCD de 3,5 polegadas, botões físicos, um D-pad, além de interfaces para áudio e bateria, proporcionando uma experiência de jogo completa. O Game HAT é compatível com vários emuladores e sistemas operacionais, como o RetroPie, permitindo rodar jogos clássicos de diversas plataformas. Essa solução é ideal para entusiastas de jogos retrô que buscam criar seus próprios consoles portáteis usando o Raspberry Pi. A imagem a seguir mostra o Game HAT.

<p align="center">
  <img src="img/gamehat.png" width = "500" />
</p>
<p align="center"><strong>Figura 4: Game HAT</strong></p>

<h3>Quartus Lite</h3>

O **Quartus Lite** é uma edição gratuita do software Quartus Prime, desenvolvido pela Intel (anteriormente conhecida como Altera). Essa ferramenta é empregada no projeto, simulação e programação de dispositivos de lógica programável, como uma FPGA ou um
Dispositivo lógico complexo programável (em inglês: *Complex Programmable Logic Device*, com sigla CPLD). No contexto deste projeto, o Quartus Lite desempenhou um papel fundamental ao ser utilizado para programar a placa FPGA e, posteriormente, transmitir essa programação por meio do *USB-Blaster*, que está integrado à placa e conectado à porta USB do computador
[Intel, 2024].

<h3>Eclipse</h3>

O **Eclipse** do Quartus é um ambiente de desenvolvimento integrado (IDE) baseado no Eclipse, utilizado para desenvolver software embarcado em sistemas com o processador NIOS II. Ele permite a criação, depuração e compilação de aplicativos em C/C++ para sistemas embarcados, oferecendo ferramentas específicas para programação de FPGAs da Intel (Altera). O ambiente facilita a integração entre o hardware descrito no Quartus e o software, permitindo o controle eficiente de periféricos e outras funções no sistema embarcado.

<h3>ModelSim</h3>

O **ModelSim** é uma ferramenta de simulação de hardware amplamente utilizada para simular o comportamento de circuitos digitais. É uma ferramenta essencial no desenvolvimento e verificação de projetos de lógica digital, incluindo circuitos integrados e FPGA. Permite criar modelos de simulação de circuitos digitais e executar testes para verificar o funcionamento correto antes de implementar o projeto em hardware real.

O ModelSim é essencial no desenvolvimento de hardware digital, pois ajuda a identificar erros, depurar problemas e otimizar o design, economizando tempo e recursos. Além da simulação funcional, suporta simulação de tempo, considerando atrasos e características temporais, permitindo verificar o desempenho em tempo real.

<h3>NIOS II</h3>

O **NIOS II** é um processador soft-core da Intel (Altera), projetado para ser usado em FPGAs, como a Cyclone IV. Ele permite personalizar o processador conforme as necessidades do projeto, ajustando dados, caches e outros recursos. Utilizado em sistemas embarcados, o NIOS II realiza tarefas como controle de periféricos e processamento de sinais, sendo programado em C/C++. Com o Quartus e o ambiente Eclipse, ele oferece uma solução flexível e eficiente para controle e processamento de hardware.

</div>
</div>

![-----------------------------------------------------](img/len.png)

<div align="justify"> 
<div id="FH"> 

<h2>Funcinalidades</h2>

</div>
</div>

![-----------------------------------------------------](img/len.png)

<div align="justify"> 
<div id="DH"> 

<h2>Arquitetura</h2>

<h3>Conjunto de Instruções</h3>


<div align="center">

| Opcode | Instrução |         Descrição         |
|--------|-----------|---------------------------|
| 0x04   |  RDEC     | Lê o registrador de dados/edgeCapture|
| 0x05   |  RCTL     | Lê o registrador de controle|
| 0x06   |  RMIRQ    | Lê o registrador de máscara de interrupção|
| 0x07   |  ------   | Não utilizado|
| 0x08   |  WDEC     | Escreve no registrador de dados/edgeCapture|
| 0x09   |  WCTL     | Escreve no registrador de controle|   
| 0x0A   |  WMIRQ    | Escreve no registrador de máscara de interrupção|

</div>
<p align="center">
<strong> Tabela com os opcodes da interface de comunicação</strong></p>

<p align="center">
  <img src="img/INT4.png" width = "1000" />
</p>
<p align="center"><strong> Formato da instrução RCTL, RDEC e RMIRQ</strong></p>


<p align="center">
  <img src="img/INT1.png" width = "1000" />
</p>
<p align="center"><strong> Formato da instrução WCTL</strong></p>

<p align="center">
  <img src="img/INT2.png" width = "1000" />
</p>
<p align="center"><strong> Formato da instrução WDEC</strong></p>

<p align="center">
  <img src="img/INT3.png" width = "1000" />
</p>
<p align="center"><strong> Formato da instrução WMIRQ</strong></p>




</div>
</div>

![-----------------------------------------------------](img/len.png)

<div align="justify"> 
<div id="D"> 

<h2>Biblioteca</h2>

Para facilitar o uso do módulo de I/O, foi desenvolvida uma biblioteca em C que contém funções para inicializar, finalizar e ler os dados dos botões e do joystick, chamada `joystick_io.h`. Ela encontrasse no diretótio `src/software/lib_joystick` do projeto. Para se utilizar essa biblioteca, basta incluir o arquivo `joystick_io.h` no código do projeto.

```c
#include "joystick_io.h"
```

Para entender como utilizar as funções do biblioteca, a seguir será explicado o funcionamento de cada uma delas, divididas em funções de controle, funções de leitura de botões e funções de leitura do joystick.

<h4>Funções de Controle</h4>

`initialize_joystick`: Inicializar o módulo de I/O para leitura dos botões e do joystick. Ao chamar essa função o módulo é reiniciado tendo os valores de controle zerados e é habilitado o sinal de enable.

**parâmetros:** 
A função não recebe parâmetros.

**retorno:** 
A função não retorna nada.

**exemplo de uso:**
```c
initialize_joystick();
```

> **Observação:** A função deve ser chamada antes de qualquer outra função.

`close_joystick`: Finalizar o módulo de I/O zerando todos os valores de controle e desabilitando o sinal de enable.

**parâmetros:**
A função não recebe parâmetros.

**retorno:**
A função não retorna nada.

**exemplo de uso:**
```c
close_joystick();
```

> **Observação:** A função  deve ser chamada ao final do programa para liberar os recursos utilizados pelo módulo de I/O.

<h4> Funções de Leitura de Botões</h4>

`read_KEY`: 

`read_KEY_edge`:

`read_KEY_edge_all`:

<h4> Funções de Leitura do Joystick</h4>

`read_JOY`:

`get_joystick_direction`:


</div>
</div>

![-----------------------------------------------------](img/len.png)
<div align="justify"> 
<div id="AP"> 

<h2>Análise de Pinout</h2>
<div align="center">

| PIN | Name PIN | FPGA PIN | Função no Controle |
|-----|----------|----------|--------------------|
| 2   | GPIO0_00  | PIN_D3  | Y                  |
| 4   | GPIO0_01  | PIN_C3  | START              |
| 6   | GPIO0_03  | PIN_A3  | A                  |
| 8   | GPIO0_05  | PIN_B4  | RIGHT              |
| 10  | GPIO0_07  | PIN_B5  | LEFT               |
| 14  | GPIO0_09  | PIN_D5  | DOWN               |
| 16  | GPIO0_011 | PIN_A6  | UP                 |
| 18  | GPIO0_013 | PIN_D6  | B                  |
| 20  | GPIO0_015 | PIN_C6  | TR                 |
| 22  | GPIO0_017 | PIN_E6  | SELECT             |
| 24  | GPIO0_019 | PIN_D8  | X                  |
| 26  | GPIO0_021 | PIN_F8  | TL                 |
| -   | CLOCK_50  | PIN_R8  | -                  |

</div>

<p align="center">
<strong> Tabela com a pinagem do FPGA De0-Nano</strong></p>

</div>
</div>

![-----------------------------------------------------](img/len.png)
<div align="justify"> 
<div id="OCF"> 

<h2>Organização do Código Fonte</h2>

</div>
</div>


![-----------------------------------------------------](img/len.png)
<div align="justify"> 
<div id="TR"> 

<h2>Testes Realizados</h2>

</div>
</div>



![-----------------------------------------------------](img/len.png)
<div align="justify"> 
<div id="EP"> 

<h2>Execução do Projeto</h2>

</div>
</div>

![-----------------------------------------------------](img/len.png)
<div align="justify"> 
<div id="referencias"> 
<h2>Referências</h2>

> Tanenbaum, Andrew S. **Organização Estruturada de Computadores**. 5. ed. São Paulo: Pearson Prentice Hall, 2003.
>
> Intel. **Software de projeto Quartus® Prime**. Disponível em: <https://www.intel.com.br/content/www/br/pt/products/details/fpga/development-tools/quartus-prime.html>
>
> Embedfire. **Design e verificação do bibliotecar de vídeo HDMI**. Disponível em: <https://doc.embedfire.com/fpga/altera/ep4ce10_pro/zh/latest/code/hdmi.html>.
>
> Ti. **PMP10580 DE0-Nano User Manual (Terasic/Altera)**.Disponível em: <https://www.ti.com/lit/ug/tidu737/tidu737.pdf>.

</div>
</div>
