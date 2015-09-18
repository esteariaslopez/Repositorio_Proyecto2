`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:43:18 07/31/2015 
// Design Name: 
// Module Name:    TopModule 
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
module TopModule(
input wire clk_i, rst_i, Conect_i, selector_temp_i, 
input wire [1:0] T_corp_in, T_amb_in,
output wire [7:0] catodo_o,
output wire Alarma_o, Ventilacion_o, presencia_nino_o,
output wire [3:0] anodo_o,
output wire [1:0] state_o,
output wire recorre_pantalla_o, escribe_o
    );
//DIvisores de frecuencia
Divisor_5x10_6 Para_escrituraLCD (
    .clk(clk_i), 
    .reset(rst_i), 
    .s_clk(s_clk)
    );
Divisor_500 Para_7seg (
    .clk(clk_i), 
    .reset(rst_i), 
    .s_clk(s_clk2)
    ); 
Divisor_1x10_7 Para_recorrerLCD (
    .clk(clk_i), 
    .reset(rst_i), 
    .s_clk(s_clk3)
    );


wire [7:0] Temp_Corp_o, Temp_Amb_o;
wire [8:0] temperatura; //8 bits de temperatura en BCD y el bit 9 para saber cual temp mostrar
wire [3:0] primer_disp, segundo_disp, tercer_disp, cuarto_disp;

//Contador emulador de temperaturas
Count_BCD64 sensor_Temp_Corporal (
    .reset_rst_in(rst_i), 
    .clock_clk_in(s_clk),  
    .down_in(T_corp_in[0]), 
    .up_in(T_corp_in[1]), 
    .q_o(Temp_Corp_o)
    );
Count_BCD64 sensor_Temp_Ambiente (
    .reset_rst_in(rst_i), 
    .clock_clk_in(s_clk),  
    .down_in(T_amb_in[0]), 
    .up_in(T_amb_in[1]), 
    .q_o(Temp_Amb_o)
    );
// Le da valor a la temperatura dependiendo del bit 8
assign temperatura = (selector_temp_i == 1'b1) ? {selector_temp_i ,Temp_Amb_o} : {selector_temp_i ,Temp_Corp_o};

FSM FSM1 (
    .clk(s_clk), 
    .rst(rst_i), 
    .Conect_i(Conect_i), 
    .Listo_C1_i(Listo_C1_i), 
    .Listo_C2_i(Listo_C2_i), 
    .temperatura_i(temperatura), 
    .EN_C1_o(EN_C1_o), 
    .EN_C2_o(EN_C2_o), 
    .state(state_o), 
    .primer_disp(primer_disp), 
    .segundo_disp(segundo_disp), 
    .tercer_disp(tercer_disp), 
    .cuarto_disp(cuarto_disp)
    );


//se eccarga de seleccionar el anodo correspondiente y traducir de BCD to 7seg
//refresca los datos del 7seg 
escritor_7Seg escritor (
    .clk_i(s_clk2), 
    .primer_disp_i(primer_disp), 
    .segundo_disp_i(segundo_disp), 
    .tercer_disp_i(tercer_disp), 
    .cuarto_disp_i(cuarto_disp), 
    .catodo_o(catodo_o), 
    .anodo_o(anodo_o)
    );

wire [5:0] escribe_q_o, recorre_q_o;
//Encargado de escribir en la LCD
ContadorUniversal EscribeLCD(
    .reset_rst_in(~EN_C1_o), 
    .clock_clk_in(s_clk), 
    .syn_clr_in(rst_i), 
    .load_in(1'd0), 
    .en_in(1'd1), 
    .up_in(1'd1), 
    .d_in(6'd0), 
    .max_tick_o(Listo_C1_i), 
    .min_tick_o(), 
    .q_o(escribe_q_o)
    );
//Encargado de recorrer la pantalla de la LCD
ContadorUniversal recorre_pantalla(
    .reset_rst_in(~EN_C2_o), 
    .clock_clk_in(s_clk3), 
    .syn_clr_in(rst_i), 
    .load_in(1'b0), 
    .en_in(1'b1), 
    .up_in(1'b1), 
    .d_in(6'd0), 
    .max_tick_o(Listo_C2_i), 
    .min_tick_o(), 
    .q_o(recorre_q_o)
    );
 assign recorre_pantalla_o = recorre_q_o[0];
 assign escribe_o = escribe_q_o[0];
 
//Logica combinacional para alarma y ventilacion
Alarma Prevencion (
    .Temp_amb(Temp_Amb_o), 
    .Temp_corp(Temp_Corp_o), 
    .Alarma(Alarma_o), 
    .Ventilacion(Ventilacion_o),
	 .presencia(presencia_nino_o)
    );


endmodule
