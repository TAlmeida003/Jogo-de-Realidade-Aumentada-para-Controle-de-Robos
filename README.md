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
        <li><a href="#io"> Módulo I/O </a></li>
        <li><a href="#referencias"> Referências </a></li>
	</ul>	
</div>


<div align="justify"> 
<div id="FPGA"> 

<h2>PINOUT</h2>

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
<h2>Referências</h2>

> Embedfire. **Design e verificação do driver de vídeo HDMI**. <https://doc.embedfire.com/fpga/altera/ep4ce10_pro/zh/latest/code/hdmi.html>.
>
> Ti. **PMP10580 DE0-Nano User Manual (Terasic/Altera)**. <https://www.ti.com/lit/ug/tidu737/tidu737.pdf>.
>

</div>
</div>
