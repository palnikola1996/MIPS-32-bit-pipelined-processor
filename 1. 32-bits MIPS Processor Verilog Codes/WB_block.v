`timescale 1ns / 1ps
//----------------------------------------------------------------------
//Created by :- Pal Nikola, Dharm Patel, Rushiraj Yadav
//Module Name :- Write back Block
//----------------------------------------------------------------------

module WB_block(ans_wb, ans_dm, clk, reset);

output reg [15:0] ans_wb;

input [15:0] ans_dm;
input clk, reset;
	 
wire [15:0] ans_dm_temp;

assign ans_dm_temp = (reset == 1'b0) ? 16'b0 : ans_dm;

always@(posedge clk) 
begin
	ans_wb <= ans_dm_temp;
end


endmodule
