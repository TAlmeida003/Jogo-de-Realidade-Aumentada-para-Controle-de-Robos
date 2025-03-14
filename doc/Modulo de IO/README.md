
<p align="center">
  <img src="img/controle.png" width = "200" />
</p>

<h1 align="center">Modulo de I/O
</h1>

<h3 align="center"> Projeto de Desenvolvimento de uma Interface de Entrada e Saída para Controle de Videogame Usando FPGA
</h3>

![-----------------------------------------------------](img/len.png)

<div align="justify"> 
<h2>Descrição do Projeto</h2>

O gerenciamento de dispositivos de Entrada/Saída, com a sigla E/S (em inglês: *Input/Output*, com a sigla I/O), sempre foi um grande
desafio na área de sistemas embarcados. Isso se deve tanto à natureza assíncrona dos dados quanto à diferença de velocidade 
entre o processador e os dispositivos periféricos, o que pode afetar significativamente o desempenho da CPU. Para fornecer uma
interface simples e confiável ao usuário e às aplicações, utiliza-se uma estrutura de camadas de hardware e software.
 Essa organização em camadas permite ocultar os detalhes específicos dos periféricos para as camadas superiores
[ANDREW S. TANENBAUM, 2003]. A Figura 1 ilustra essa arquitetura de camadas entre o software e o hardware.

<p align="center">
  <img src="img/camadas.png" width = "800" />
</p>
<p align="center"><strong>Figura 1: Arquitetura de camadas entre o software e o hardware</strong></p>

Neste projeto, o foco está no gerenciamento dos periféricos de um controle de videogame.
Desenvolveu-se um **módulo de I/O** de 64 bits em Verilog, uma linguagem de descrição de hardware, 
implementado em uma matriz de portas programáveis (em inglês: *Field-Programmable Gate Array*, com a sigla FPGA) com processador **NIOS II**, acompanhado de uma biblioteca em linguagem C para facilitar o acesso ao hardware. 
O principal objetivo desse módulo é realizar a leitura dos dados dos botões e do joystick. 
Ele é responsável por capturar e armazenar as informações provenientes dos periféricos e transmiti-las
à CPU sob demanda ou via interrupção. Além disso, o módulo processa as configurações solicitadas pelo processador por meio de software. 
Este projeto detalhará o funcionamento do módulo tanto no nível de hardware quanto no nível de software, 
abordando sua arquitetura, interfaces e como os desenvolvedores podem integrá-lo em suas aplicações. Para se ter uma visão geral do sistema,
a Figura 2 apresenta o diagrama geral do projeto.

<p align="center">
  <img src="img/geral.png" width = "1000" />
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
<div id="FH"> 

<h2>Funcinalidades</h2>

Nesta seção, serão apresentadas as funcionalidades do módulo de I/O, que incluem o gerenciamento dos dados dos botões e do joystick, além do controle de interrupções.

<h3>Gerenciamento de Botões e Joystick</h3>

O módulo de hardware desenvolvido realiza a leitura dos dados dos botões e do joystick, armazenando-os em registradores internos. O sistema suporta 8 botões (Y, X, A, B, TL, TX, START e SELECT) e um joystick com 4 direções (UP, DOWN, LEFT e RIGHT). Para cada botão e direção do joystick, é possível ler o estado atual (1 para ativo/pressinado e 0 para o desativado/solto) e o estado de borda (subida, descida ou ambos).

Os dados dos botões e do joystick são armazenados em registradores de 64 bits, permitindo a leitura simultânea de todos os botões e direções. O módulo também conta com registradores de controle que permitem habilitar ou desabilitar a leitura dos botões e do joystick, além de configurar o controle de borda e sua seleção. 

Além disso, o módulo possui regisradores de captura de borda que armazenam as mudanças de borda dos periféricos, permitindo a detecção de bordas para que o processador possa identificar que um botão foi pressionado ou o joystick foi movido, mesmo que o estado do periférico tenha mudado. Isso é útil para
poder detectar eventos mesmo que o processador não tenha lido o estado do periférico no momento da mudança. 

> **Observação:** Os registradores armazenam o estado de borda para leitura pelo processador. 
> Ao realizar a leitura, é necessário limpar o registrador de captura de borda via software.

<h3>Controle de Interrupção</h3> 

O módulo de I/O oferece suporte a interrupções para notificar o processador sobre eventos importantes, como a pressão de um botão ou o movimento do joystick. Quando um botão é pressionado ou o joystick é movido, o módulo gera uma interrupção que permite ao processador tratar o evento imediatamente. Isso possibilita uma resposta rápida a entradas, eliminando a necessidade de verificar constantemente os botões e o joystick (*polling*).

Além disso, o módulo possui registradores de máscara de interrupção que permitem habilitar ou desabilitar interrupções específicas, possibilitando a seleção de quais eventos devem acionar interrupções.

A interrupção pode ser configurada para borda ou nível, permitindo que o processador seja notificado quando um botão é pressionado ou solto, ou quando o joystick é movido em uma direção específica. Isso torna o controle de interrupção mais flexível e eficiente, garantindo que o processador possa responder rapidamente a eventos de entrada.

> **Observação:** Ao gerar uma interrução, o módulo de I/O envia um sinal para o processador, que deve tratar a interrupção e limpar o registrador de captura de borda para evitar interrupções repetidas. 
> Em caso de nível, a interrupção é gerada enquanto o botão estiver pressionado e pode ser desativada pela mascará de interrupção.


</div>
</div>

![-----------------------------------------------------](img/len.png)

<div align="justify"> 
<div id="DH"> 

<h2>Arquitetura do Modulo de I/O</h2>

Essa seção apresenta a arquitetura do módulo de I/O, detalhando sua estrutura interna, interfaces e funcionamento. O módulo é composto por cinco submódulos principais: **Opcode Control**, **Register Controller**, **Edge Capture Clear**, **IO Data** e **Select Data Read**. Cada submódulo desempenha funções específicas para gerenciar os dados dos botões e do joystick, controlar interrupções e processar comandos do processador.
Além disso, o módulo de I/O possui um **conjunto de instruções** para comunicação com o processador, permitindo ler e escrever dados nos registradores internos e configurar os parâmetros de controle e interrupção.

<h3>Interface do modulo de I/O</h3>

Para se comunicar com o barramento de sistema, o modulo de I/O é equipado com 145 pinos. Para facilitar a compreensão da organização desses pinos, a tabela a seguir fornece uma visão detalhada de cada um deles.


<div align="center">

| Nome   | Tipo       | tamanho |         Descrição         | Exposição na FPGA |
|--------|------------|---------|---------------------------|---|
| clk    | Entrada    | 1       | Sinal de clock de entrada | Não |
| rst_n  | Entrada    | 1       | Sinal de reset ativo em nível baixo | Não |
| we     | Entrada    | 1       | Sinal de escrita ativo em nível alto | Não |
| buttons| Entrada    | 8       | Barramento para leitura dos botões | Sim |
| joystick| Entrada   | 4       | Barramento para leitura do joystick | Sim |
| writedata| Entrada  | 64      | Barramento para escrita de dados | Não |
| readdata| Saída     | 64      | Barramento para leitura de dados | Não |
| waitrequest| Saída  | 1       | Sinal para indicar que o módulo está ocupado | Não |
| irq    | Saída      | 1       | Sinal de interrupção para o processador | Não |
</div>
<p align="center">
<strong> Tabela 1: Pinagem do módulo de I/O</strong></p>

A Figura 5 apresenta o diagrama em blocos da interface do módulo de I/O, com as conexão entre os submódulos e a interface do módulo com o barramento do sistema. As entradas e saídas provenientes dos barramentos estão localizadas à esquerda, enquanto as entradas expostas na FPGA estão à direita.


<p align="center">
  <img src="img/diagIO.png" width = "800" />
</p>
<p align="center"><strong>Figura 5: Diagrama em blocos da interface do módulo de I/O</strong></p>

<h3>Discrição Geral</h3>

Nesta seção, abordamos uma visão ampla do projeto experimental. Começamos analisando o diagrama de blocos geral, mostrado na Figura 6. Esse diagrama ilustra todas as conexões entre os submódulos do módulo de I/O.

<p align="center">
  <img src="img/total.png" width = "1300" />
</p>
<p align="center"><strong>Figura 6: Diagrama de blocos geral da interface do módulo de I/O</strong></p>

<h4>Opcode Controller</h4>

O **módulo Opcode Controler** é responsável por interpretar os 
opcodes enviados e direcionalos corretamente para o módulo.
Em termos de montagem de hardware, ele é capaz de interpretar dados nos formatos de 32 e 64 bits, ajustando automaticamente os dados conforme o formato especificado. Essa configuração pode ser alterada no arquivo *Verilog* do módulo, modificando o parâmetro **CPU** para 32 ou 64 bits.

Se um opcode não pertencer ao conjunto reconhecido pelo módulo, sua saída é zerada para evitar erros de leitura. Quando o endereço **3** é utilizado dentro do módulo não é realiza nenhuma operação.

O módulo conta com as seguintes entradas e saídas:

<div align="center">

| Nome   | Tipo       | tamanho |         Descrição         |
|--------|------------|---------|---------------------------|
|in_reg_data | Entrada    | 64       | Barramento com os dados de enviados pelo processador |
|opcode | Entrada    | 4       | Barramento com os opcodes  retirados dos 4 bits iniciais do in_reg_data|
|out_reg_data | Saída   | 64      | Barramento com os dados de entrada do módulo |
|we | Saída   | 1      | Sinal de escrita |
|addr | Saída   | 2      | Barramento com o endereço do registrador|

</div>

<p align="center">
<strong> Tabela 2: Entradas e saídas do módulo Opcode Control</strong></p>

Para garantir a visualização do módulo, segue a imagem do diagrama de blocos do módulo.


<div align="center">
  <img src="img/opcodeController.png" width = "800" />
</div>
<p align="center"><strong>Figura 7: Diagrama de blocos do módulo Opcode Control</strong></p>

<h4>Register Controller</h4>

O **módulo de Register Controller** gerencia o estado das configurações do módulo de I/O e a máscara de interrupção. 
Ele contém um **registrador de controle**, acessível pelo endereço **0**, com várias funções: um bit para reiniciar **(RST)** o módulo 
(0 para reiniciar e 1 para manter o estado atual), um bit de enable (0 para desativar o módulo e impedir alterações, e 1 para 
permitir modificações), um bit para habilitar ou desabilitar o cancelamento de ruído **(RCR)** (0 para usar o sinal atual do botão e 1 
para ativar os registradores de captura de borda), e um seletor de borda ou nivel **(CCR)** que pode ser configurado como descida (00), subida (01), ambas (10) ou nivel (11). Cada um dos 12 periféricos de entrada possui um espaço no registrador para controlar o tipo de dado e a borda.
A figura a seguir ilustra a organização dos registradores de controle.

<p align="center">
  <img src="img/register_controlle.png" width = "800" />
</p>
<p align="center"><strong>Figura 8: registrador de controle</strong></p>

Além disso, o módulo de I/O inclui um **registrador de máscara de interrupção**, acessível pelo endereço **2**, 
que permite habilitar ou desabilitar interrupções específicas. Cada bit desse registrador corresponde a um
periférico de entrada, permitindo a seleção de quais devem acionar a interrupção **(IRQ)**. Também há dois bits 
reservados para cada periférico, permitindo definir a borda na qual a interrupção será acionada **(CCR)** suas opções são semelhantes ao CCR do registrador de controle. A figura 
a seguir mostra a estrutura do registrador de máscara de interrupção.

<p align="center">
  <img src="img/register_irq.png" width = "800" />
</p>
<p align="center"><strong>Figura 9: registrador de máscara de interrupção</strong></p>

Por fim, o módulo conta com as seguintes entradas e saídas:

<div align="center">

| Nome   | Tipo       | tamanho |         Descrição         |
|--------|------------|---------|---------------------------|
| clk    | Entrada    | 1       | Sinal de clock de entrada |
| rst_n  | Entrada    | 1       | Sinal de reset ativo em nível baixo |
| we     | Entrada    | 1       | Sinal de escrita ativo em nível alto |
|register_addr | Entrada | 2       | Barramento para endereço do registrador |
|wr_data | Entrada    | 64      | Barramento para escrita de dados |
|out_control | Saída   | 64      | Barramento para leitura de dados do registrador de controle|
|out_interrupt| Saída   | 64      | Barramento para leitura dedados do registrador de máscara de interrupção|
|done | Saída   | 1      | Sinal que indica se a escrita foi realizada com sucesso

</div>
<p align="center">
<strong> Tabela 3: Entradas e saídas do módulo de controle</strong></p>

Para facilitar a visualização segue uma imagem do diagrama de blocos do módule.

<div align="center">
  <img src="img/registerController.png" width = "800" />
</div>
<p align="center"><strong>Figura 10: Diagrama de blocos do módulo de controle</strong></p>

<h4>Edge Capture Clear</h4>

O **módulo Edge Capture Clear** é responsável por limpar os registradores de captura de borda, que armazenam as mudanças de estado dos periféricos. Ele é ativado pelo processador, que envia um sinal de escrita para realizar a limpeza. Para acessar este módulo, o processador deve escrever no endereço 1, correspondente ao registrador de dados. Ao escrever o valor 1 no bit que representa o periférico desejado **(RS)**, o respectivo registrador de captura de borda é limpo. A figura a seguir ilustra a estrutura do registrador de captura de borda e dados.

<p align="center">
  <img src="img/register_data.png" width = "800" />
</p>
<p align="center"><strong>Figura 11: registrador de dados e captura de borda</strong></p>

> **Observação:** O sinal de limpeza depende da configuração de borda do registrador de controle. Por exemplo, se a borda estiver configurada como subida, a limpeza ocorrerá apenas no registrador de subida, e os demais registradores não serão afetados.

O módulo conta com as seguintes entradas e saídas:

<div align="center">

| Nome   | Tipo       | tamanho |         Descrição         |
|--------|------------|---------|---------------------------|
|clk    | Entrada    | 1       | Sinal de clock de entrada |
|rst_n  | Entrada    | 1       | Sinal de reset ativo em nível baixo |
|we     | Entrada    | 1       | Sinal de escrita ativo em nível alto |
|enable | Entrada    | 1       | Sinal de habilitação da limpeza |
|register_addr | Entrada | 2       | Barramento para endereço do registrador |
|wr_data | Entrada    | 12      | Barramento para escrita de dados |
|noise_canc | Entrada    | 12      | Barramento para limpeza de ruído |
|clear_data | Saída   | 12      | Barramento para leitura de dados limpos |
|done | Saída   | 1      | Sinal que indica se a escrita foi realizada com sucesso

</div>
<p align="center">
<strong> Tabela 4: Entradas e saídas do módulo de limpeza de borda</strong></p>

Para garantir a visualização do módulo, segue a imagem do diagrama de blocos do módulo.

<div align="center">
  <img src="img/edgeCaptureClear.png" width = "800" />
</div>
<p align="center"><strong>Figura 12: Diagrama de blocos do módulo de limpeza de borda</strong></p>

<h4>IO Data</h4>

O **módulo IO Data** é responsável por armazenar os dados dos botões e do joystick. Ele contém quatro registradores de 1 bit para cada periférico: três registradores para captura de borda (subida, descida e ambas) e um para o estado atual. Dessa forma, os registradores de captura de borda e o sinal de interrupção, que dependem desses registradores, são gerenciados dentro deste módulo.

A saída de dados do módulo é controlada pelo registrador de controle, que determina se o dado a ser lido é referente às bordas ou ao estado atual. Para habilitar os registradores de captura de borda, é necessário ativar o sinal de enable do módulo, assim como o **Registrador de Cancelamento de Ruído (RCR)**. Caso o enable esteja ativado, mas o RCR não, os registradores de captura de borda não serão capazes de alterar seu estado.

Uma decisão importante no design foi utilizar uma única saída multiplexada para selecionar o tipo de dado a ser lido, o que economiza espaço e simplifica o controle de dados.

Por exemplo, se o usuário deseja ler o estado atual do botão Y, ele deve escrever o valor **11** na seção correspondente ao botão Y no registrador de controle (CCR). Isso direcionará a saída do módulo IO Data para o estado atual do botão Y. Da mesma forma, para ler as bordas, o usuário precisa ativar o enable e o RCR, e então escrever o valor **00** no campo CCR.

A interrupção é gerada quando um dos registradores de dados detecta uma mudança de borda ou quando o valor atual do periférico é baixo, uma vez que todos os periféricos funcionam como ***pull-up***. Para habilitar a interrupção, o usuário deve escrever o valor **1** no campo correspondente ao periférico desejado no registrador de máscara de interrupção, assim como configurar o tipo de interrupção.

O módulo conta com as seguintes entradas e saídas:

<div align="center">

| Nome   | Tipo       | tamanho |         Descrição         |
|--------|------------|---------|---------------------------|
|clk    | Entrada    | 1       | Sinal de clock de entrada |
|rst_n  | Entrada    | 1       | Sinal de reset ativo em nível baixo |
|enable | Entrada    | 1       | Sinal de habilita os registradores|
| en_noise_cancelling | Entrada    | 12       | Barramento para habilitar o registradores de captura de borda |
|interrupt_mask | Entrada    | 12       | Barramento para habilitar a interrupção |
|in_data | Entrada    | 12       | Barramento para leitura dos periféricos |
|select_edge | Entrada    | 24       | Barramento para seleção de borda |
|select_interrupt | Entrada    | 24       | Barramento para seleção de tipo de interrupção|
|clr | Entrada    | 12       | Sinal de limpeza de registrador de captura |
|out_data | Saída   | 64      | Barramento para leitura de dados |
|irq | Saída   | 1      | Sinal de interrupção|

</div>
<p align="center">
<strong> Tabela 5: Entradas e saídas do módulo de IO Data</strong></p>

Para garantir a visualização do módulo, segue a imagem do diagrama de blocos do módulo.

<div align="center">

  <img src="img/ioData.png" width = "800" />

</div>

<p align="center"><strong>Figura 13: Diagrama de blocos do módulo IO Data</strong></p>

<h4>Select Data Read</h4>

O **módulo Select Data Read** é responsável por selecionar o tipo de dado que será lido pelo processador. Seu funcionamento é de um multiplexador 4 para 1, que seleciona o tipo de dado 
com base no valor dos seletores. Nesse sentido, é usado como entrada de seleção o endereço dos registradore e assim pode ter as sequintes saídas:

<div align="center">

|Endereço |        Descrição         |
|--------|---------------------------|
| 0b00      | Registrador de dados     |
| 0b01      | Registrador de controle  |
| 0b10      | Registrador de máscara de interrupção |
| 0b11      |  Não utilizado |

</div>
<p align="center">
<strong> Tabela 6: Saídas do módulo Select Data Read</strong></p>

O módulo conta com as seguintes entradas e saídas:

<div align="center">

| Nome   | Tipo       | tamanho |         Descrição         |
|--------|------------|---------|---------------------------|
|reg_control | Entrada    | 64       | Barramento com os dados do registrador de controle |
|reg_data_io | Entrada    | 64       | Barramento com os dados do registrador de dados/captura de borda |
|reg_interrupt | Entrada    | 64       | Barramento com os dados do registrador de máscara de interrupção |
|read_addr | Entrada    | 2       | Barramento para seleção do tipo de dado |
|read_data | Saída   | 64      | Barramento para leitura de dados |

</div>
<p align="center">
<strong> Tabela 7: Entradas e saídas do módulo Select Data Read</strong></p>

Para garantir a visualização do módulo, segue a imagem do diagrama de blocos do módulo.

<div align="center">
  <img src="img/selectDataRead.png" width = "800" />
</div>
<p align="center"><strong>Figura 14: Diagrama de blocos do módulo Select Data Read</strong></p>

<h3> Comunicação com o Processador</h3>

O módulo de I/O é controlado pelo processador NIOS II, que envia comandos para ler e escrever dados nos registradores internos do módulo. Para realizar essa comunicação, utiliza-se acesso direto à memória, sem o uso de mapeamento de memória. O processador se comunica com todos os módulos da arquitetura através do barramento **Avalon MM** de 32 bits. Para acomodar o módulo de I/O, foi definida uma estrutura de 64 bits, visando a compatibilidade com projetos futuros.

Para integrar o barramento Avalon ao módulo de I/O, foi necessário implementar um intermediário. Embora essa decisão tenha acarretado a perda de alguns sinais de controle, ela permitiu manter a estrutura de 64 bits para expansões futuras. Para utilizar a leitura de dados, o processdor deve escrever o registrador desejado com base no **conjunto de instrução** e, em seguida, ler o valor do registrador de saída.

A comunicação entre o processador e o módulo de I/O é realizada por meio do **PIO-Core**, utilizando quatro módulos de 32 bits (dois para escrita e dois para leitura). Além disso, um módulo específico para escrita, o **módulo de pulso de escrita**, foi implementado. Esse módulo capta o sinal de um endereço de memória e gera um pulso para o módulo de I/O. Para efetuar a escrita, o processador deve primeiro atribuir o valor 1 ao endereço de memória correspondente e, em seguida, atribuir o valor 0 ao mesmo endereço, garantindo assim que o módulo de I/O realize a operação de escrita.

A seguir, está o diagrama de blocos que ilustra a arquitetura completa do sistema, facilitando a visualização dessa estrutura.

<div align="center">
  <img src="img/arqT.png" width = "800" />
</div>
<p align="center"><strong>Figura 15: Diagrama de blocos da arquitetura geral</strong></p>

<h3>Conjunto de Instruções</h3>

O módulo de I/O suporta um conjunto de instruções para comunicação com o processador. 
Essas instruções permitem ler e escrever dados nos registradores internos do módulo, bem como configurar os 
parâmetros de controle. A tabela a seguir apresenta o conjunto de instruções suportadas pelo módulo de I/O.


<div align="center">

| Opcode | Instrução |         Descrição         |
|--------|-----------|---------------------------|
| 0x04   |  RDEC     | Lê o registrador de dados/edgeCapture|
| 0x05   |  RCTL     | Lê o registrador de controle|
| 0x06   |  RMIRQ    | Lê o registrador de máscara de interrupção|
| 0x07   |  WDEC     | Escreve no registrador de dados/edgeCapture|
| 0x08   |  WCTL     | Escreve no registrador de controle|   
| 0x09   |  WMIRQ    | Escreve no registrador de máscara de interrupção|

</div>

<p align="center">
<strong> Tabela 8: Opcodes da interface de comunicação</strong></p>

<h4> Instruções RCTL, RDEC e RMIRQ</h4>

As **instruções RCTL, RDEC e RMIRQ** são usadas para ler registradores específicos: RCTL lê o registrador de controle, 
RDEC lê o registrador de dados/captura de borda (*edgeCapture*), e RMIRQ lê o registrador de máscara de interrupção. 
Quando o opcode correspondente ao registrador é escrito, o valor do registrador respectivo é enviado para os registradores de 
leitura. A figura a seguir ilustra o formato dessas instruções.

<p align="center"> <img src="img/INT4.png" width="1000" /> </p> <p align="center"><strong> Figura 16: Formato das instruções RCTL, RDEC e RMIRQ</strong></p>

Para uso na arquitetura de 32 bits, a instrução é dividida em duas partes: a primeira (32 bits mais significativos, sigla MSB) parte
 contém o opcode, enquanto a segunda (32 bits menos significativos, sigla LSB) parte é um campo vazio, reservado para possíveis expansões ou configurações adicionais.

<p align="center"> <img src="img/INT4_32.png" width="1000" /> </p> <p align="center"><strong> Figura 17: Formato das instruções RCTL, RDEC e RMIRQ com 32 bits</strong></p>

<h4> Instrução WCTL</h4>

A **instrução WCTL** é usada para escrever no registrador de controle. O processador deve enviar o opcode correspondente ao registrador de controle, seguido pelo valor a ser escrito. A figura a seguir ilustra o formato dessa instrução.

<p align="center">
  <img src="img/INT1.png" width = "1000" />
</p>
<p align="center"><strong> Figura 18: Formato da instrução WCTL</strong></p>

Para uso na arquitetura de 32 bits, a instrução é dividida em duas partes: a primeira (MSB) parte contém o opcode, o sinal de enable, o sinal de reset e o sinal de cancelamento de ruído, enquanto a segunda (LSB) parte contém o seletor de borda. 
A figura a seguir ilustra o formato dessa instrução para 32 bits.

<p align="center">
  <img src="img/INT1_32.png" width = "1000" />
</p>
<p align="center"><strong>  Figura 19: Formato da instrução WCTL para 2 partes de 32 bits</strong></p>

<h4> Instrução WDEC</h4>

A **instrução WDEC** é usada para escrever no registrador de dados/captura de borda (*edgeCapture*). Ao Utilizar essa instrução, os regisradores de captura de borda são limpos nos locais onde o valor 1 é escrito. A figura a seguir ilustra o formato dessa instrução.

<p align="center">
  <img src="img/INT3.png" width = "1000" />
</p>
<p align="center"><strong>Figura 20: Formato da instrução WDEC</strong></p>

Para uso na arquitetura de 32 bits, a instrução é dividido em duas partes: a primeira (MSB) parte contém o opcode, enquanto a segunda (LSB) parte é os registradores de captura de borda a serem limpos. A figura a seguir ilustra o formato dessa instrução para 32 bits.

<p align="center">
  <img src="img/INT3_32.png" width = "1000" />
</p>
<p align="center"><strong> Figura 21: Formato da instrução WDEC para 2 partes de 32 bits</strong></p>

<h4> Instrução WMIRQ</h4>

A **instrução WMIRQ** é usada para escrever no registrador de máscara de interrupção. Ela permite habilitar ou desabilitar interrupções específicas, configurando o tipo de interrupção para cada periférico. A figura a seguir ilustra o formato dessa instrução.

<p align="center">
  <img src="img/INT2.png" width = "1000" />
</p>
<p align="center"><strong> Figura 22: Formato da instrução WMIRQ</strong></p>

Para uso na arquitetura de 32 bits, a instrução é dividida em duas partes: a primeira (MSB) parte contém o opcode e a seleção de interrupção, enquanto a segunda (LSB) parte é o seletor de borda. A figura a seguir ilustra o formato dessa instrução para 32 bits.

<p align="center">
  <img src="img/INT2_32.png" width = "1000" />
</p>
<p align="center"><strong> Figura 23: Formato da instrução WMIRQ para 2 partes de 32 bits</strong></p>


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

Para entender como utilizar as funções da biblioteca e suas constantes, a seguir será explicado o funcionamento de cada uma delas.

<h3>Constantes</h3>

Para facilitar o uso do módulo de I/O, foram definidas algumas
constantes que representam o botões, as direções do joystick e 
as formas de leitura dos botões e do joystick. A tabela a seguir mostra as constantes definidas na biblioteca.

<div align="center">

|Constante         | Valor | Descrição |
|------------------|-------|-----------|
| SELECT_BUTTON    | 0     | Representação do botão SELECT |
| START_BUTTON     | 1     | Representação do botão START |
| TL_BUTTON        | 2     | Representação do botão TL |
| TR_BUTTON        | 3     | Representação do botão TR |
| B_BUTTON         | 4     | Representação do botão B |
| A_BUTTON         | 5     | Representação do botão A |
| Y_BUTTON         | 6     | Representação do botão Y |
| X_BUTTON         | 7     | Representação do botão X |
| LEFT_DIR      | 8     | Representação da direção LEFT do joystick |
| RIGHT_DIR     | 9     | Representação da direção RIGHT do joystick |
| UP_DIR        | 10    | Representação da direção UP do joystick |
| DOWN_DIR      | 11    | Representação da direção DOWN do joystick |
| POS_EDGE  | 0     | Representação da borda de subida |
| NEG_EDGE  | 1     | Representação da borda de descida |
| BOTH_EDGE | 2     | Representação de ambas as bordas |
| LEVEL    | 3     | Representação do estado atual do botão ou direção do joystick |

</div>

<p align="center">
<strong> Tabela 9: Constantes definidas na biblioteca</strong></p>


<h3>Funções</h3>

`initialize_joystick`: Inicializar o módulo de I/O para leitura dos botões e do joystick. Ao chamar essa função o módulo é reiniciado tendo os valores de controle zerados e é habilitado o sinal de enable. Além disso, é habilitado o cancelamento de ruído.

**parâmetros:** 
A função não recebe parâmetros.

**retorno:** 
A função não retorna nada.

**Cabeçalho da função:**
```c
void initialize_joystick(void);
```

**exemplo de uso:**
```c
initialize_joystick();
```

> **Observação:** A função deve ser chamada antes de qualquer outra função.

`close_joystick`: Finalizar o módulo de I/O zerando todos os valores de controle.

**parâmetros:**
A função não recebe parâmetros.

**retorno:**
A função não retorna nada.

**Cabeçalho da função:**
```c
void close_joystick(void);
```

**exemplo de uso:**
```c
close_joystick();
```

> **Observação:** A função  deve ser chamada ao final do programa para liberar os recursos utilizados pelo módulo de I/O.

`read_KEY`: Ler o estado de um botão específico. Esta função permite verificar o estado de um botão, identificando se houve uma mudança (borda) ou apenas o estado atual do botão.

**parâmetros:**

- `KEY`: O botão a ser lido. Deve ser uma das constantes definidas na biblioteca, como `Y`, `X`, `A`, `B`, `TL`, `TX`, `START` ou `SELECT`.

- `state`: estado a ser verificado. Pode ser uma das seguintes constantes:

  - `POS_EDGE`: Verifica se o botão foi pressionado (borda de subida);

  - `NEG_EDGE`: Verifica se o botão foi solto (borda de descida);

  - `BOTH_EDGE`: Verifica se houve uma mudança de borda no botão;

  - `LEVEL`: Lê o estado atual do botão, sem considerar mudanças de borda.

**retorno:**

A função retorna **1** se o botão estiver no estado especificado e **0** caso contrário.

**Cabeçalho da função:**
```c
int read_KEY(unsigned int KEY, unsigned int state);
```

**exemplo de uso:**
```c
// Verificando se o botão Y foi pressionado

if (read_KEY(Y, POS_EDGE)) {
    // Botão Y foi pressionado
}
```

```c
// Verificando se o botão B foi solto

if (read_KEY(B, NEG_EDGE)) {
    // Botão B foi solto
}
```

```c
// Verificar se houve uma mudança de borda no botão A

if (read_KEY(A, BOTH_EDGE)) {
    // Botão A teve uma mudança de borda
}
```

```c
// Verificar o estado atual do botão X

if (read_KEY(X, LEVEL)) {
    // Botão X está pressionado
}
```

`read_JOYSTICK`: Ler o estado de uma direção específica do joystick. Esta função permite verificar o estado de uma direção do joystick, identificando se houve uma mudança (borda) ou apenas o estado atual da direção.

**parâmetros:**

- `direction`: A direção do joystick a ser lida. Deve ser uma das constantes pré-definidas na biblioteca, como `UP`, `DOWN`, `LEFT`, `RIGHT`.

- `state`: estado a ser verificado. Pode ser uma das seguintes constantes:

  - `POS_EDGE`: Verifica se a direção foi ativada (borda de subida);

  - `NEG_EDGE`: Verifica se a direção foi desativada (borda de descida);

  - `BOTH_EDGE`: Verifica se houve uma mudança de borda na direção;

  - `LEVEL`: Lê o estado atual da direção, sem considerar mudanças de borda.

**retorno:**

A função retorna **1** se a direção estiver no estado especificado e **0** caso contrário.

**Cabeçalho da função:**
```c
int read_JOYSTICK(unsigned int direction, unsigned int state);
```

**exemplo de uso:**
```c
// Verificando se a direção UP foi ativada (borda de subida)
if (read_JOYSTICK(UP, POS_EDGE)) {
    // A direção UP foi pressionada
}
```

```c
// Verificando se a direção LEFT foi desativada (borda de descida)
if (read_JOYSTICK(LEFT, NEG_EDGE)) {
    // A direção LEFT foi solta
}
```

```c
// Verificando se houve uma mudança de borda na direção RIGHT
if (read_JOYSTICK(RIGHT, BOTH_EDGE)) {
    // A direção RIGHT teve uma mudança de borda
}
```

```c
// Verificando o estado atual da direção DOWN
if (read_JOYSTICK(DOWN, LEVEL)) {
    // A direção DOWN está sendo pressionada
}
```


`set_callback`: Configurar uma função de callback para ser chamada quando uma interrupção for gerada. Esta função permite definir uma função de callback que será chamada quando uma interrupção for gerada pelo módulo de I/O.

**parâmetros:**

- `callback`: Ponteiro para a função de callback. A função de callback deve ter o seguinte protótipo:

```c
void callback(void)
```

**retorno:**
Sem retorno.

**Cabeçalho da função:**
```c
void set_callback(void (*callback)(void));
```

**exemplo de uso:**
```c
void my_callback() {
    // Função de callback
}

set_callback(my_callback);
```

> **Observação:** As funções de callback devem ser definidas
pelo usuário, a biblioteca não fornece a logica de limpeza de interrupção de borda, essa deve ser feita pelo usuário, usando a função `read_JOYSTICK` ou `read_KEY` para limpar a interrupção.


`peripheral_enable_callback`: Habilita um periférico específico para gerar interrupções em uma borda específica.

**parâmetros:**

- `peripheral`: O periférico a ser habilitado. Deve ser uma das constantes pré-definidas na biblioteca, como `Y`, `X`, `A`, `B`, `TL`, `TX`, `START` ou `SELECT`.

- `state`: A borda na qual a interrupção deve ser gerada. Deve ser uma das constantes pré-definidas na biblioteca, como `POS_EDGE`, `NEG_EDGE`, `BOTH_EDGE` ou `LEVEL`.

**retorno:**
Sem retorno.

**Cabeçalho da função:**
```c
void peripheral_enable_callback(unsigned int peripheral, unsigned int state);
```

**exemplo de uso:**
```c
// Habilitando o botão Y para gerar interrupções na borda de subida
peripheral_enable_callback(Y, POS_EDGE);
```
```c
// Habilitando a direção UP do joystick para gerar interrupções na borda de descida
peripheral_enable_callback(UP, NEG_EDGE);
```
```c
// habilitando o botão SELECT para gerar interrupção em troca de borda
peripheral_enable_callback(SELECT, BOTH_EDGE);
```
```c
// habilitando o botão START para gerar interrupção por nivel
peripheral_enable_callback(START, LEVEL);
```


`peripheral_disable_callback`: Desabilita um periférico específico para gerar interrupções.

**parâmetros:**

- `peripheral`: O periférico a ser desabilitado. Deve ser uma das constantes pré-definidas na biblioteca, como `Y`, `X`, `A`, `B`, `TL`, `TX`, `START` ou `SELECT`.

**retorno:**
Sem retorno.

**Cabeçalho da função:**
```c
void peripheral_disable_callback(unsigned int peripheral);
```

**exemplo de uso:**
```c
peripheral_disable_callback(Y);
```

</div>
</div>

![-----------------------------------------------------](img/len.png)
<div align="justify"> 
<div id="AP"> 


<h2>Análise de Pinout</h2>

Para utilizar o projeto é necessário usar alguns pinos e periféricos da FPGA DE0-Nano. A tabela a seguir mostra a pinagem utilizada no projeto.

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
<strong> Tabela 10: Pinagem do FPGA De0-Nano</strong></p>

Para utilizar os botões do controle foi ncessario utilizar um resistor de *pull-up* interno da FPGA, para isso foi necessário configurar o pino como entrada e ativar o resistor de *weak pull-up resistor*. Para visualizar
como foi feito a configuração dos pinos, segue o *chip planner* do Quartus.

<p align="center">
  <img src="img/chip-planner.png" width = "1000" />
</p>
<p align="center"><strong>Figura 24: Chip Planner do Quartus</strong></p>

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
<div id="referencias"> 
<h2>Referências</h2>

> Tanenbaum, Andrew S. **Organização Estruturada de Computadores**. 5. ed. São Paulo: Pearson Prentice Hall, 2003.
>
> Embarcados. **DE0-Nano**. Disponível em: <https://www.embarcados.com.br/de0-nano/>. Acesso em: 15 de Outrubro de 2024.
>
> Waveshare. **Game HAT**. Disponível em: <https://www.waveshare.com/wiki/Game_HAT>. Acesso em: 15 de Outrubro de 2024.
>
> Macnica. **nstallation instructions for using Nios® II Software Build Tools / SoC Embedded Development Suite with Quartus® Prime Pro Edition 19.1**. Disponível: <https://www.macnica.co.jp/en/business/semiconductor/articles/intel/133716/>. Acesso em: 15 de Outrubro de 2024.
>
> Embarcados. **Tutorial de Modelsim: Verificando o VHDL antes de programar o FPGA**. Disponível em: <https://embarcados.com.br/tutorial-de-modelsim-vhdl-fpga/>. Acesso em: 15 de Outrubro de 2024.
>
> Embarcados. **Processador softcore Altera Nios II**. Disponível em: <https://embarcados.com.br/altera-nios-ii/>. Acesso em: 15 de Outrubro de 2024.
>
> Intel. **PIO Core**. Disponível em: <https://www.intel.com/content/www/us/en/docs/programmable/683130/21-3/pio-core.html>. Acesso em: 16 de Outrubro de 2024.
>
> Intel. **Software de projeto Quartus® Prime**. Disponível em: <https://www.intel.com.br/content/www/br/pt/products/details/fpga/development-tools/quartus-prime.html>
>
> Embedfire. **Design e verificação do bibliotecar de vídeo HDMI**. Disponível em: <https://doc.embedfire.com/fpga/altera/ep4ce10_pro/zh/latest/code/hdmi.html>.
>
> Ti. **PMP10580 DE0-Nano User Manual (Terasic/Altera)**.Disponível em: <https://www.ti.com/lit/ug/tidu737/tidu737.pdf>.

</div>
</div>
