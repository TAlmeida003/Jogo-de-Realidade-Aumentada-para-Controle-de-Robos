`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: FEUP - Faculdade de Engenharia da Univeridade do Porto 
// Student: Ricardo Jorge dos Santos Machado (050503177)
// 
// Create Date:		10:30:58 06/14/2010
// Module Name:		SVGA_sync 
// Description:		Módulo de sincronização para SVGA gráfico (800 x 600).
//
// Version:			1.0
//
// Additional Comments:	Destinado a funcionar com o clock interno de 50MHz.
//						hsync e vsync são linhas do conector VGA.
//						video_enable indica se estamos na parte visivel do monitor.
//						pixel_x e pixel_y indicam as coordenadas do pixel.
//
//////////////////////////////////////////////////////////////////////////////////
module VGA_sync(clock, reset, hsync, vsync, video_enable, pixel_x, pixel_y, printting);

input				clock, reset;

output reg			hsync, vsync;
output reg [9:0]	pixel_x;
output reg [9:0]	pixel_y;
output wire			video_enable;
output wire         printting;

/*	Parâmetros Horizontais */
parameter	HD = 640;   //active horizontal area
parameter	HF = 16;    //front Porch
parameter	HB = 48;    //back Porch
parameter	HR = 96;    //pulses of H_sync
parameter	HT = 800;   //total

/*	Parâmetros Verticais */
parameter	VD = 480;  //active vertical area
parameter	VF = 11;   //Front Porch
parameter	VB = 31;   //back Porch
parameter	VR = 2;    //pulses of V_sync
parameter	VT = 524;  //total

assign video_enable   = ((pixel_x < HD) && (pixel_y < VD));
assign printting      = ((pixel_y < VD) && (reset == 1'b1) ) ? 1'b1 : 1'b0;

always @ (posedge clock or negedge reset)	// Processamento de pixel_x.
begin
	if (!reset)
	begin
		pixel_x <= 0;
	end
	else
	begin
		if (pixel_x == (HT - 1))			// Ultimo pixel horizontal.
 		begin
			pixel_x <= 0;
		end
		else
		begin
			pixel_x <= pixel_x + 10'd1;		
		end
	end
end

always @ (posedge clock or negedge reset)	// Processamento de pixel_y.
begin
	if (!reset)
	begin
		pixel_y <= 0;
	end
	else
	begin
		if ((pixel_y == (VT - 1))&& (pixel_x == (HT - 1)))			// Ultimo pixel horizontal e vertical.
		begin
			pixel_y <= 0;
		end
		else
		begin
			if ((pixel_x == (HT - 1)))		// Ultimo pixel horizontal.
			begin
				pixel_y <= pixel_y + 10'd1;
			end
		end
	end
end

always @ (posedge clock or negedge reset)	// Processamento de hsync.
begin
	if (!reset)
	begin
		hsync <= 1'b0;
	end
	else
	begin
		if (pixel_x == (HD + HF - 1))		// Inicio de hsync.
	  	begin
			hsync <= 1'b1;
		end
		else 
		begin
			if (pixel_x == (HT - HB - 1))	// Fim de hsync.
			begin
				hsync <= 1'b0;
			end
		end
	end
end

always @ (posedge clock or negedge reset)	// Processamento de vsync.
begin
	if (!reset)
	begin
		vsync = 1'b0;
	end
	else
	begin
		if ((pixel_y == (VD + VF - 1) && (pixel_x == HT - 1)))			// Inicio de vsync.
	  	begin
			vsync = 1'b1;
		end
		else
		begin
			if ((pixel_y == (VT - VB - 1)) && (pixel_x == (HT - 1)))	// Fim de vsync.
			begin
				vsync = 1'b0;
			end
		end
	end
end

endmodule