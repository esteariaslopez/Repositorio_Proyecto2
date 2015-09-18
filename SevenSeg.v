`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:50:09 08/03/2015 
// Design Name: 
// Module Name:    SevenSeg 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module escritor_7Seg(
	input wire clk_i,
	input wire [3:0] primer_disp_i,segundo_disp_i,tercer_disp_i,cuarto_disp_i,
	output wire [7:0] catodo_o,
	output reg [3:0] anodo_o
    ); 
	 
	reg [3:0] display;
	reg Conect_type;
	 
	initial
		begin
			anodo_o <= 4'b1110;
			Conect_type <= 1'b0;
		end
//shift left a los anodos
//selecciona cual 7seg se está mostrando de momento
	always@(posedge clk_i)
		begin
			if (anodo_o == 4'b0111)
				anodo_o <= 4'b1110;
			else
				begin
					anodo_o <= {anodo_o[2:0],1'b1};
				end
		end
	always@*
		display <= (anodo_o == 4'b1110) ? primer_disp_i :
					  (anodo_o == 4'b1101) ? segundo_disp_i :
					  (anodo_o == 4'b1011) ? tercer_disp_i :
					  cuarto_disp_i;

//En este modulo se encuentran decodificados en hexadecimal 16 simbolos para el 7seg
//0,1,2,3,4,5,6,7,8,9,A,o,C,D,E,OFF en ese orden
	BCD_to_7seg bcd_to_7seg1 (
    .bcd_i(display), 
    .sev_seg_o(catodo_o)
    );
	

endmodule
