`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:52:53 07/31/2015 
// Design Name: 
// Module Name:    ContadorUniversal 
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
module ContadorUniversal
 #(parameter N=6)
(input wire reset_rst_in, clock_clk_in,
 input wire syn_clr_in , load_in, en_in, up_in,
 input wire [N-1:0] d_in,
 output wire max_tick_o, min_tick_o,
 output wire [N-1:0] q_o
);



// declaración de señales
reg [N-1:0] estado_actual, estado_siguiente;
//wire clock_clk_in;

// registro de estado
always @(posedge clock_clk_in, posedge reset_rst_in)
if (reset_rst_in)
estado_actual <= 0; 
else
estado_actual <= estado_siguiente;


// lógica del estado siguiente
always @*
if (syn_clr_in)
		estado_siguiente = 0;
else if (load_in)
		estado_siguiente = d_in;
else if (en_in & up_in)
		estado_siguiente = estado_actual + 1'b1;
else if (en_in & ~up_in)
		estado_siguiente = estado_actual - 1'b1;
else
		estado_siguiente = estado_actual;


// lógica de salidas
assign q_o = estado_actual;
assign max_tick_o = (estado_actual==2**N-1) ? 1'b1 : 1'b0; 
assign min_tick_o = (estado_actual==0) ? 1'b1 : 1'b0;  


endmodule
