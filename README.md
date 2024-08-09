<p align="center">
  <img src="img/kart.png" width = "350" />
</p>

<h1 align="center">Game Kart
</h1>

<h3 align="center"> Projeto de Desenvolvimento de uma Interface Portátil para Teleoperação de Robô em Ambiente de 
Realidade Aumentada Usando FPGA
</h3>

<h1 align="center"> Sumário </h1>
<div id="sumario">
	<ul>
        <li><a href="#FPGA"> FPGA De0-Nano </a></li>
        <li><a href="#gpu"> Graphics Processing Unit (GPU) </a></li>
        <li><a href="#hdmi"> High-Definition Multimedia Interface (HDMI) </a></li>
        <li><a href="#controle"> Interface Portátil </a></li>
        <li><a href="#referencias"> Referências </a></li>
	</ul>	
</div>


<div align="justify"> 
<div id="FPGA"> 

<h2>FPGA De0-Nano</h2>

Modelo Altera Cyclone IV **EP4CE22F17C6N** FPGA;

<h3>Pinagem</h3>

<p align="center">
  <img src="img/GPIO.png" width = "600" />
</p>
<p align="center"><strong>Elementos Utilizados na Pinagem do FPGA</strong></p>


<div align="center">

| PIN | Name PIN | FPGA PIN | Função no Controle |
|-----|----------|----------|--------------------|
| 2   | GPIO0_00  | PIN_D3  | Y                  |
| 4   | GPIO0_01  | PIN_C3  | START              |
| 6   | GPIO0_03  | PIN_A3  | A                  |
| 8   | GPIO0_05  | PIN_B4  | RIGHT              |
| 10  | GPIO0_07  | PIN_B5  | LEFT               |
| 12  | GND       | -       | -                  |
| 14  | GPIO0_09  | PIN_D5  | DOWN               |
| 16  | GPIO0_011 | PIN_A6  | UP                 |
| 18  | GPIO0_013 | PIN_D6  | B                  |
| 20  | GPIO0_015 | PIN_C6  | TR                 |
| 22  | GPIO0_017 | PIN_E6  | SELECT             |
| 24  | GPIO0_019 | PIN_D8  | X                  |
| 26  | GPIO0_021 | PIN_F8  | TL                 |
| 30  | GND       |         | -                  |
| -   | CLOCK_50  | PIN_R8  | -                  |

</div>

<p align="center">
<strong> Tabela com a pinagem do FPGA De0-Nano</strong></p>


</div>
</div>

<div align="justify">
<div id="gpu">
<h2>Graphics Processing Unit (GPU)</h2>



</div>
</div>


<div align="justify"> 
<div id="hdmi"> 
<h2>High-Definition Multimedia Interface (HDMI)</h2>

<h3> Pinagem </h3>

<p align="center">
  <img src="img/HDMI.png" width = "400" />
</p>
<p align="center"><strong>Organização dos pinos do HDMI</strong></p>

<div align="center">

| PIN   | Definição                        | | PIN | Definição                                  |
|-------|----------------------------------|-|-----|--------------------------------------------|
| 1  	  | Dados2+ (TMDS Dados2+)           | | 11  | Escudo do Relógio (Escudo do Relógio TMDS) |
| 2  	  | Escudo TMDS Data2                | | 12  | Relógio- (Relógio TMDS–)                   |
| 3  	  | Dados2- (Dados TMDS2-)           | | 13  | CEC                                        |
| 4  	  | Dados1+ (Dados TMDS1+)           | | 14  | reserva                                    |
| 5  	  | Escudo TMDS Data1                | | 15  | Linha de relógio DDC (SCL)                 |
| 6  	  | Dados1- (Dados TMDS1-)           | | 16  | Linha de dados DDC (SDA)                   |
| 7  	  | Dados0+ (Dados TMDS0+)           | | 17  | DDC/CEC GND                                |
| 8  	  | Escudo Data0 (Escudo Data0 TMDS) | | 18  | Fonte de alimentação +5V (alimentação)     |
| 9  	  | Dados0- (Dados TMDS0-)           | | 19  | Detecção de hot plug                       |
| 10  	 | Relógio+ (Relógio TMDS+)         | | -   | -                                          |

</div>
<p align="center">
<strong> Tabela com a pinagem do HDMI </strong></p>

<h3> Transition Minimized Differential signal (TMDS) </h3>

O sistema de transmissão TMDS em HDMI é dividido em duas partes: a extremidade de envio e a extremidade de recepção. O 
transmissor TMDS recebe dados paralelos de 24 bits representando o sinal RGB da interface HDMI (TMDS codifica as três 
cores primárias RGB de cada pixel em 8 bits, ou seja, o sinal R possui 8 bits, o sinal G possui 8 bits e o sinal B tem
8 bits), então codifica e converte esses dados e sinais de clock em paralelo/serial e, em seguida, distribui os dados e 
sinais de clock que representam os três sinais RGB para canais de transmissão independentes e os envia. A extremidade 
receptora recebe o sinal serial da extremidade transmissora, decodifica-o e converte-o em serial/paralelo e, em seguida,
envia-o para a extremidade de controle do display. Simultaneamente, o sinal do relógio também é recebido para obter 
a sincronização.

<p align="center">
  <img src="img/DiagramaTMDS.png" width = "700" />
</p>
<p align="center"><strong>Diagrama de funcionamento do TMDS</strong></p>


</div>
</div>

<div align="justify"> 
<div id="controle"> 

<h2>Inteface Portátil
</h2>

<h3>Pinagem
</h3>

<div align="center">

| PIN  | Definição | | PIN | Definição |
|------|-----------|-|-----|-----------|
| 1  	 | 3.3 V     | | 2   | 5 V       |
| 7    | SELECT V  | | 4   | 5 V       |
| 9    | GND       | | 6   | GND       |
| 17   | 3.3 V     | | 12  | TL        |
| 25   | GND       | | 14  | GND       |
| 29   | UP        | | 16  | TR        |
| 31   | DOWN      | | 20  | GND       |
| 33   | LEFT      | | 30  | GND       |
| 35   | RIGHT     | | 32  | B         |
| 37   | A         | | 34  | GND       |
| 39   | GND       | | 36  | X         |
| -    | -         | | 38  | Y         |
| -    | -         | | 40  | START     |

</div>

<p align="center">
<strong> Tabela com a pinagem do controle</strong></p>

</div>
</div>

<div align="justify"> 
<div id="referencias"> 
<h2>Referências</h2>

> Embedfire. **Design e verificação do driver de vídeo HDMI**. <https://doc.embedfire.com/fpga/altera/ep4ce10_pro/zh/latest/code/hdmi.html>.
>
> Ti. **PMP10580 DE0-Nano User Manual (Terasic/Altera)**. <https://www.ti.com/lit/ug/tidu737/tidu737.pdf>.
>

</div>
</div>
