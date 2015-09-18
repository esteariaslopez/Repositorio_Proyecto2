`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:49:41 08/03/2015 
// Design Name: 
// Module Name:    Display 
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
module display_estados(
    input wire [1:0] estado_in,
    output wire [6:0] catodos_o,
    output an_o
    );
	// always@*
		begin
			assign catodos_o =( estado_in == 2'b00) ? 7'b1001111 :
							( estado_in == 2'b01) ? 7'b0010010 :
							( estado_in == 2'b10) ? 7'b0000110 :
							7'b1001100;
		end
		
	assign an_o = 1'b0;
endmodule
