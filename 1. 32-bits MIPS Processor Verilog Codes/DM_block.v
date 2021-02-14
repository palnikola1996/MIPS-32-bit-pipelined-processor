`timescale 1ns / 1ps
//----------------------------------------------------------------------
//Created by :- Pal Nikola, Dharm Patel, Rushiraj Yadav
//Module Name :- Data Memory
//----------------------------------------------------------------------

module DM_block(ans_dm, ans_ex, DM_data, mem_en_ex, mem_rw_ex, mem_mux_sel_dm, clk, reset);

input [15:0] ans_ex;
input [15:0] DM_data;
input mem_en_ex;
input mem_rw_ex;
input mem_mux_sel_dm;
input clk;
input  reset;

output [15:0] ans_dm;
	 
wire[15:0] DM_out;	 
reg [15:0] Ex_out; 

wire [15:0] ans_ex_temp;
	
DM DMB(
  .clka(clk), // input clka
  .ena(mem_en_ex), // input ena
  .wea(mem_rw_ex), // input [0 : 0] wea
  .addra(ans_ex), // input [15 : 0] addra
  .dina(DM_data), // input [15 : 0] dina
  .douta(DM_out) // output [15 : 0] douta
);

assign ans_ex_temp = (reset == 1'b1) ? ans_ex : 16'b0;

always@(posedge clk) 
begin
	Ex_out <= ans_ex_temp;
end

assign ans_dm = (mem_mux_sel_dm == 1'b1 )? DM_out : Ex_out;

endmodule
