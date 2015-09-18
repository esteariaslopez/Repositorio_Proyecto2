`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:12:33 08/04/2015 
// Design Name: 
// Module Name:    Count_BCD64 
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
module Count_BCD64
(input wire reset_rst_in, clock_clk_in,
 input wire down_in, up_in,
 output wire [7:0] q_o
);



// declaración de señales
reg [7:0] estado_actual, estado_siguiente;
//wire clock_clk_in;
initial
	begin
	estado_actual = 8'b00100000;
	estado_actual = 8'b00100000;
	end
// registro de estado
always @(posedge clock_clk_in, posedge reset_rst_in)
	if (reset_rst_in)
		estado_actual <= 8'b00100000; 
	else
		estado_actual <= estado_siguiente;



// lógica del estado siguiente
always @*
	if (up_in == 1'b1)
		begin
		estado_siguiente[3:0] = (estado_actual[3:0]==4'b1001)? 4'b0000 : estado_actual[3:0] + 1'b1;
		estado_siguiente[7:4] = (estado_actual[3:0]==4'b1001)? estado_actual[7:4] + 1'b1 : estado_actual[7:4];
		end
	else if (down_in == 1'b1)
		begin
		estado_siguiente[3:0] = (estado_actual[3:0]==4'b0000)? 4'b1001 : estado_actual[3:0] - 1'b1;
		estado_siguiente[7:4] = (estado_actual[3:0]==4'b0000)? estado_actual[7:4] - 1'b1 : estado_actual[7:4];
		end
	else
			estado_siguiente = estado_actual;


// lógica de salidas
assign q_o = estado_actual;
  
endmodule
