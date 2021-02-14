`timescale 1ns / 1ps
//----------------------------------------------------------------------
//Created by :- Pal Nikola, Dharm Patel, Rushiraj Yadav
//Module Name :- Main module
//----------------------------------------------------------------------

module MIPS_main_module(data_out, data_in, interrupt, clk, reset);
	 
output [15:0] data_out;

input [15:0] data_in;
input interrupt, clk, reset;

wire [31:0] ins; 
wire [15:0] current_address, jmp_loc, A, B, ans_ex, ans_dm, ans_wb, imm, DM_data; 
wire [5:0] op_dec; 
wire [4:0] RW_dm; 
wire [1:0] mux_sel_A, mux_sel_B, flag_ex; 
wire clk, reset, pc_mux_sel, stall, stall_pm, imm_sel, mem_en_ex, mem_rw_ex, mem_mux_sel_dm; 
	 
PC_IM_block PC (ins, current_address, jmp_loc, pc_mux_sel, stall, stall_pm, clk, reset);

Reg_bank RB (A, B, ans_ex, ans_dm, ans_wb, imm, ins[20:16], ins[15:11], RW_dm, mux_sel_A, mux_sel_B, imm_sel, clk);

Ex_block EX (data_out, ans_ex, DM_data, flag_ex, data_in, A, B, op_dec, clk, reset);

DM_block DM (ans_dm, ans_ex, DM_data, mem_en_ex, mem_rw_ex, mem_mux_sel_dm, clk, reset);

WB_block WB (ans_wb, ans_dm, clk, reset);

SC_block SC (stall, stall_pm, ins[31:26], clk, reset);

JC_block JC (jmp_loc, pc_mux_sel, current_address, ins[15:0], ins[31:26], flag_ex, interrupt, clk, reset);

DC_block DC (imm, op_dec, RW_dm, mux_sel_A, mux_sel_B, imm_sel, mem_rw_ex, mem_mux_sel_dm, mem_en_ex, ins, clk, reset);

endmodule
