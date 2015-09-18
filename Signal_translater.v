`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:05:18 09/02/2015 
// Design Name: 
// Module Name:    Signal_translater 
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
module Signal_translater(
	input wire [7:0] key_code,
	output reg Conect, selector_temp, rst,
	output reg [1:0] T_corp, T_amb
    );
	 
	initial begin
					T_corp = 2'b0;T_amb  = 2'b0;
					Conect = 0;selector_temp = 0;
					rst = 0;
			  end
	
	wire dato_in,dato_in1;
	assign dato_in = key_code[0]|key_code[1]|key_code[2]|key_code[3]|key_code[4]|key_code[5]|key_code[6]|key_code[7];
	
	BUFG BUFG_inst (
      .O(dato_in1), // 1-bit output: Clock buffer output
      .I(dato_in)  // 1-bit input: Clock buffer input
   );
	
	always@*
		begin
			T_corp [1] = (key_code == 8'h75)?  1'b1 : 1'b0; 
			T_corp [0] = (key_code == 8'h72)?  1'b1 : 1'b0;
			T_amb [1]  = (key_code == 8'h74)?  1'b1 : 1'b0; 
			T_amb [0]  = (key_code == 8'h6B)?  1'b1 : 1'b0; 
			Conect =  (key_code == 8'h5A)? 1'b1 : 1'b0;
		end
	always@(posedge dato_in1)
		begin
			selector_temp = (key_code == 8'h29)? ~selector_temp : selector_temp;
			rst =  (key_code == 8'h76)? ~rst : rst;
		end

endmodule
