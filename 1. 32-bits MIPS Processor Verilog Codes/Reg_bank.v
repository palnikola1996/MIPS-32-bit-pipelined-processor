`timescale 1ns / 1ps
//----------------------------------------------------------------------
//Created by :- Pal Nikola, Dharm Patel, Rushiraj Yadav
//Module Name :- Register Bank
//----------------------------------------------------------------------

module Reg_bank(A, B, ans_ex, ans_dm, ans_wb, imm, RA, RB, RW_dm, mux_sel_A, mux_sel_B, imm_sel, clk);

output [15:0] A, B;

input [15:0] ans_ex, ans_dm, ans_wb, imm;
input [4:0] RA, RB, RW_dm;
input [1:0] mux_sel_A, mux_sel_B;
input imm_sel, clk;
 
reg  [15:0] reg_bank[31:0], reg_A, reg_B;

always @ (posedge clk) 
begin
	reg_A <= reg_bank[RA];
	reg_B <= reg_bank[RB];	
	reg_bank[RW_dm] <= ans_dm;	
end

assign A = (mux_sel_A[1] == 1'b0) ? ((mux_sel_A[0] == 1'b0) ? reg_A: ans_ex) : ((mux_sel_A[0] == 1'b0) ? ans_dm: ans_wb);
assign B = (imm_sel == 1'b0) ? ((mux_sel_B[1] == 1'b0) ? ((mux_sel_B[0] == 1'b0) ? reg_B: ans_ex) : ((mux_sel_B[0] == 1'b0) ? ans_dm: ans_wb)): imm;

endmodule
