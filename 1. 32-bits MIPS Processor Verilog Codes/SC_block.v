`timescale 1ns / 1ps
//----------------------------------------------------------------------
//Created by :- Pal Nikola, Dharm Patel, Rushiraj Yadav
//Module Name :- Stall Control Block
//----------------------------------------------------------------------

module SC_block(stall, stall_pm, op, clk, reset);

output stall;
output reg stall_pm;

input [5:0] op;
input clk, reset;

wire hlt, ld, jmp;
wire ld_fb_temp, ljmp_fb1_temp, jmp_fb2_temp, stall_pm_temp; 

reg ld_fb, jmp_fb1, jmp_fb2; 
 
assign hlt = (~op[5])&(op[4])&(~op[3])&(~op[2])&(~op[1])&(op[0]);
assign ld = (~op[5])&(op[4])&(~op[3])&(op[2])&(~op[1])&(~op[0])&(~ld_fb);
assign jmp = (~op[5])&(op[4])&(op[3])&(op[2])&(~jmp_fb2);

assign stall = hlt|ld|jmp;

assign jmp_fb2_temp = (reset == 1'b0) ? 1'b0 : jmp_fb1;
assign jmp_fb1_temp = (reset == 1'b0) ? 1'b0 : jmp;
assign ld_fb_temp = (reset == 1'b0) ? 1'b0 : ld;
assign stall_pm_temp = (reset == 1'b0) ? 1'b0 : stall;

always@(posedge clk )
begin
		jmp_fb2 <= jmp_fb2_temp;
		jmp_fb1 <= jmp_fb1_temp;
		ld_fb <= ld_fb_temp;
		stall_pm <= stall_pm_temp;
end

endmodule
