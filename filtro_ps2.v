`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:33:11 08/24/2015 
// Design Name: 
// Module Name:    filtro_ps2 
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
// Este módulo filtra los datos enviados del teclado para que almacene el valor que está despues de F0
//////////////////////////////////////////////////////////////////////////////////
module filtro_ps2(
input wire clk , reset,
input wire ps2d, ps2c, 
output wire [7:0] key_code
    );

// constant declaration
localparam BRK = 8'b11110000; // break code 

// symbolic state declaration
localparam 
wait_brk = 1'b0,
get_code = 1'b1;


// signal declaration
reg state_reg , state_next;
wire [7:0] scan_out;
reg got_code_tick;
wire got_code_tick_2;
wire scan_done_tick;
reg [7:0] code;

ps2_rx ps2_rx_unit
(. clk(clk), .reset(reset), 
.ps2d(ps2d), .ps2c(ps2c),
.rx_done_tick(scan_done_tick), .dout(scan_out));



code_pulse pulse (
    .clk(clk), 
    .reset(reset), 
    .tick(got_code_tick), 
    .data_in(code), 
    .data_out(key_code)
    );



BUFG BUFG_inst (
      .O(got_code_tick_2), // 1-bit output: Clock buffer output
      .I(got_code_tick)  // 1-bit input: Clock buffer input
   );


// state registers
always @(posedge clk, posedge reset)
if (reset)
	state_reg <= wait_brk;
else
	state_reg <= state_next;
	
	
always @*
begin
	got_code_tick = 1'b0;
	state_next = state_reg;
	
case (state_reg)
	wait_brk: // wait for F0 of break code
		if (scan_done_tick==1'b1 && scan_out==BRK)
		state_next = get_code;
	get_code: // get the following scan code
		if (scan_done_tick)
			begin
				got_code_tick =1'b1;
				state_next = wait_brk;
				
			end
		endcase
end

always @(posedge got_code_tick_2, posedge reset)
if (reset)
code <= 0;
else
if (scan_out!=BRK)
code <= scan_out;


endmodule
