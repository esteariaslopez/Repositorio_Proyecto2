`timescale 1s / 1ms
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:21:56 08/11/2015 
// Design Name: 
// Module Name:    Alarma 
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
module Alarma(
    input wire [7:0] Temp_amb,
    input wire [7:0] Temp_corp,
    output reg Alarma,
    output reg Ventilacion,
	 output reg presencia
    );
	 
	always@*
		begin 
			if (Temp_corp[7:4] == 4'd3)
				begin
					Alarma = (Temp_corp[3:0] >= 4'd8);
					presencia = (Temp_corp[3:0] >= 4'd6);
				end
			else 
				begin 
					presencia = (Temp_corp[7:4] >= 4'd4)? 1'b1 : 1'b0;
					Alarma = (Temp_corp[7:4] >= 4'd4)? 1'b1 : 1'b0; 
				end
	 
			if (presencia)
				if (Temp_amb[7:4] == 4'd2)
						Ventilacion = (Temp_amb[3:0] >= 4'd5);
				else Ventilacion = (Temp_amb[7:4] >= 4'd3)? 1'b1 : 1'b0;
			else Ventilacion = 1'b0;
		end
	
endmodule
