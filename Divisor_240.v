`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:12:29 08/04/2015 
// Design Name: 
// Module Name:    Divisor_240 
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
module Divisor_500 (
	input wire clk,       //Señal de entrada, referente a comportamiento de reloj.
	input wire reset,     //Reset de señal.
	output reg s_clk      //Señal de salida del divisor, señal ya dividida.
    );
	 
// El codigo de este módulo corresponde a dividir la frecuencia de entrada en 5 veces, ejemplo: 100Mhz => 20Mhz.
//
//  ** 
//     Si se desea dividir en otra cantidad, por ejemplo: en 354, primero se saca la base 2 de ese numero
//		 para poder obtener la cantidad del largo del bus datos referente a la salida del contador
//		 log2(354) = 8.4676 => por lo que se toma el numero entero posterior al resultado, osea 9
//     Por lo que las siguientes lineas de código tendria se cambiarían por lo siguiente:
//
//     linea  |  Cambio
//     -------+----------------------------
//		  43    |    reg [8:0] cuenta;
//	 	  55    |    if (cuenta == 9'd353)
//   	  58    |    cuenta <= 9'h0;
//
//  **

	
reg [17:0] cuenta; //Bus de datos de 3 bits referente al contador
					   //para una unidad decimal maxima de 8 (2^3 = 8) suficiente para la cuenta de 5.
//initial 
//	cuenta = 8'd0;
always @(posedge clk,posedge reset) //Se procede a realizar el codigo posterior siempre que "clk" o "reset" estén en alto.
	begin
		if (reset) //Si "reset" está en alto, se pone la salida "s_clk" en 0 y se resetea la cuenta.
			begin
				s_clk <= 0;
				cuenta <= 0;
			end 
		else //Se está en alto la señal de "clk" pero no la de "reset" se procede a realizar lo siguiente.
			begin		
				if (cuenta == 18'd200000)//(5)-1 = 4, Si el contador llega a la cuenta 5:   
					//Por si las dudas => "3'd4"(notación decimal) es igual a "3'b100"(notación binaria). 
					begin                    
						cuenta <= 18'h0;  //Se resetea la cuenta poniendola en cero   
						s_clk <= ~s_clk;  //
					end 
				else 
					cuenta <= cuenta + 1'b1; //De no ser el valor a dividir, el contador seguirá contando (valga la redundancia)
			end
	end
 
endmodule

