`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:19:18 09/02/2015 
// Design Name: 
// Module Name:    TOPTOP 
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
module TOPTOP(
	input wire clk_i, rst_i, ps2d, ps2c,
	output wire Alarma_o, Ventilacion_o, presencia_nino_o, 
	output wire recorre_pantalla_o, escribe_o,
	output wire [1:0] state_o,
	output wire [3:0] anodo_o,
	output wire [7:0] catodo_o
    );
wire [1:0] T_corp, T_amb;
wire [7:0] key_code;

TopModule Sistema_alarmas ( 
    .clk_i(clk_i), 
    .rst_i(rst), 
    .Conect_i(Conect), 
    .selector_temp_i(selector_temp), 
    .T_corp_in(T_corp), 
    .T_amb_in(T_amb), 
    .catodo_o(catodo_o), 
    .Alarma_o(Alarma_o), 
    .Ventilacion_o(Ventilacion_o), 
    .presencia_nino_o(presencia_nino_o), 
    .anodo_o(anodo_o), 
    .state_o(state_o), 
    .recorre_pantalla_o(recorre_pantalla_o), 
    .escribe_o(escribe_o)
    );
	 
filtro_ps2 Filtro_teclado (
    .clk(clk_i), 
    .reset(rst_i),
    .ps2d(ps2d), 
    .ps2c(ps2c),  
    .key_code(key_code)
    );


Signal_translater traductor ( 
    .key_code(key_code), 
    .Conect(Conect), 
    .selector_temp(selector_temp), 
    .rst(rst), 
    .T_corp(T_corp), 
    .T_amb(T_amb)
    );


endmodule
