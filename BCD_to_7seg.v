`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:31:09 08/03/2015 
// Design Name: 
// Module Name:    BCD_to_7seg 
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
module BCD_to_7seg(
	input wire [3:0] bcd_i,
	output reg [7:0] sev_seg_o
    );
	
	initial
		sev_seg_o <= 8'b11111111;
	
	always@*
		begin
			if (bcd_i == 4'h0)
				sev_seg_o <= 8'b00000011;
			else if (bcd_i == 4'h1)
				sev_seg_o <= 8'b10011111;
			else if (bcd_i == 4'h2)
				sev_seg_o <= 8'b00100101;
			else if (bcd_i == 4'h3)
				sev_seg_o <= 8'b00001101;
			else if (bcd_i == 4'h4)
				sev_seg_o <= 8'b10011001;
			else if (bcd_i == 4'h5)//
				sev_seg_o <= 8'b01001001;
			else if (bcd_i == 4'h6)//
				sev_seg_o <= 8'b11000001;
			else if (bcd_i == 4'h7)//
				sev_seg_o <= 8'b00011111;
			else if (bcd_i == 4'h8)//
				sev_seg_o <= 8'b00000001;
			else if (bcd_i == 4'h9)//
				sev_seg_o <= 8'b00011001;
			else if (bcd_i == 4'hA)//
				sev_seg_o <= 8'b00010001;
			else if (bcd_i == 4'hB)//
				sev_seg_o <= 8'b11000100;
			else if (bcd_i == 4'hC)//
				sev_seg_o <= 8'b11100101;
			else if (bcd_i == 4'hD)//
				sev_seg_o <= 8'b10000101;
			else if (bcd_i == 4'hE)//
				sev_seg_o <= 8'b01100000;
			else 
				sev_seg_o <= 8'b11111111;
				
		end
endmodule
//	parameter cero = 4'b0000; parameter uno = 4'b0001; parameter dos = 4'b0010; parameter tres = 4'b0011;
//	parameter cuatro = 4'b0100; parameter cinco = 4'b0101;parameter seis = 4'b0110; parameter siete = 4'b0111;
//	parameter ocho = 4'b1000; parameter nueve = 4'b1001; parameter Te = 4'b1010; parameter O = 4'b1011;
//	parameter Ce = 4'b1100; parameter De = 4'b1101; parameter E = 4'b1110;
//	
//	always@*
//	begin
//		case (bcd_i)
//			cero  : sev_seg_o <= 8'b00000011;
//			uno   : sev_seg_o <= 8'b10011111;
//			tres  : sev_seg_o <= 8'b00001101;
//			cuatro: sev_seg_o <= 8'b10011001;
//			cinco : sev_seg_o <= 8'b01001001;
//			seis  : sev_seg_o <= 8'b11000001;
//			siete : sev_seg_o <= 8'b00011111;
//			ocho  : sev_seg_o <= 8'b00000001;
//			nueve : sev_seg_o <= 8'b00011001;
//			Te    : sev_seg_o <= 8'b01110010;
//			O     : sev_seg_o <= 8'b00000010;
//			Ce    : sev_seg_o <= 8'b01100010;
//			De    : sev_seg_o <= 8'b00000010;
//			E     : sev_seg_o <= 8'b01100000;
//			
//		endcase
//	end

