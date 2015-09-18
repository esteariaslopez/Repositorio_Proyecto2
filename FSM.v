`timescale 1s / 1ms
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:01:51 07/30/2015 
// Design Name: 
// Module Name:    FSM 
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
module FSM(
    input wire clk, rst, Conect_i, Listo_C1_i, Listo_C2_i,
	 input wire [8:0] temperatura_i,
    output reg EN_C1_o, EN_C2_o,
	 output reg [1:0] state,
	 output reg [3:0] primer_disp,segundo_disp,tercer_disp,cuarto_disp
    );
	 
	parameter s1=2'b00; parameter s2=2'b01;
	parameter s3=2'b10; parameter s4=2'b11;
	
	reg [1:0] Conect;
	
	
	initial 
		begin
			state <= 2'b00; EN_C1_o <= 1'b1; EN_C2_o <= 1'b0; 
			Conect <= 2'b00;
		end

//Logica del estado siguiente
always@(posedge clk or posedge rst)
	begin
		if (rst)
			begin 
				state <= s1;Conect <= 2'b00;
			end 
		else 
			begin
			//Si entra la señal Conect_i porque se concectó o desconectó un dispositivo
			//
				if (Conect_i == 1'b1)
					Conect [0] <= 1'b1;
				else Conect [0] <= Conect [0];
				
				case (state)
					s1: 
						begin
							if (Listo_C1_i == 1'b1)
								begin 
									state <= s2;
								end 
							else
								begin
									state <= s1;
								end
						end 
					s2: 
						begin
							if (Conect[0] == 1'b1)
								begin 
									state <= s3;
								end
							else
								begin 
									state <= s1;
								end
						end
					s3: 
						begin
							if (Listo_C1_i==1'b1)
								begin
									state <= s4;
								end
							else
								begin
									state <= s3;
								end
						end
					s4:
						begin
							if (Listo_C2_i==1'b1)
								begin
									state <= s1;
									Conect <= Conect + 1'b1; //
								end
							else 
								begin
									state <= s4;
								end
						end
				endcase
			end
	end
//Decodificador de salidas
	always@*
		begin		
			cuarto_disp <= {2'b00, state};
			if ((state == s1) | (state == s2))
					begin
						EN_C1_o <= 1'b1; EN_C2_o <= 1'b0;
						primer_disp <= temperatura_i [3:0];
						segundo_disp <= temperatura_i [7:4];
						tercer_disp <= temperatura_i [8] ? 4'hA : 4'hC;
					end
			else if (state == s3)
					begin
						EN_C1_o <= 1'b1; EN_C2_o <= 1'b0;
						primer_disp <= Conect[1]? 4'hE : 4'hB;
						segundo_disp <= Conect[1]? 4'hD : 4'hC;
						tercer_disp <= 4'hE;
					end
			else
					begin
						EN_C1_o <= 1'b0; EN_C2_o <= 1'b1;
						primer_disp <= Conect[1]? 4'hE : 4'hB;
						segundo_disp <= Conect[1]? 4'hD : 4'hC;
						tercer_disp <= 4'hF;
					end
				
		end
	
endmodule
