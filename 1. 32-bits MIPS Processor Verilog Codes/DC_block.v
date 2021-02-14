`timescale 1ns / 1ps
//----------------------------------------------------------------------
//Created by :- Pal Nikola, Dharm Patel, Rushiraj Yadav
//Module Name :- Dependency Check and Instruction Decode Block
//----------------------------------------------------------------------

module DC_block(imm, op_dec, RW_dm, mux_sel_A, mux_sel_B, imm_sel, mem_rw_ex, mem_mux_sel_dm, mem_en_ex, ins, clk, reset);

output reg [15:0] imm;
output reg [5:0] op_dec;
output reg [4:0] RW_dm;
output [1:0] mux_sel_A;
output [1:0] mux_sel_B;
output reg imm_sel, mem_rw_ex, mem_mux_sel_dm, mem_en_ex;

input [31:0] ins;
input clk;
input reset;

wire [15:0] imm_temp;
wire [14:0] block_bus, ins_block;
wire [4:0] RA_dec_temp, RB_dec_temp, RW_dec_temp, RW_ex_temp, RW_dm_temp, RW_wb_temp;
wire [5:0] op_dec_temp;
wire jmp, jmp_cond, ld_with_fb, immediate, ld, st, block_bit, RA_comp_ex, RA_comp_dm, RA_comp_wb, RB_comp_ex, RB_comp_dm, RB_comp_wb, mem_en_ld, mem_en_dec;
wire ld_fb_temp, mem_rw_dec_temp, mem_en_ld_temp, mem_en_ld_dec_temp, st_temp, mem_en_st_dec_temp, mem_rw_ex_temp, mem_mux_sel_ex_temp, mem_en_ex_temp, mem_mux_sel_dm_temp, imm_sel_temp;

reg [4:0] RA_dec, RB_dec, RW_dec, RW_ex, RW_wb;
reg ld_fb, mem_rw_dec, mem_en_ld_dec, mem_en_st_dec, mem_mux_sel_ex;

assign jmp = ~ins[31] & ins[30] & ins[29] & ~ins[28] & ~ins[27] & ~ins[26];
assign jmp_cond = ~ins[31] & ins[30] & ins[29] & ins[28];
assign ld_with_fb = ~ins[31] & ins[30] & ~ins[29] & ins[28] & ~ins[27] & ~ins[26] & ~ld_fb;
assign immediate = ~ins[31] & ~ins[30] & ins[29];
assign ld = ~ins[31] & ins[30] & ~ins[29] & ins[28] & ~ins[27] & ~ins[26];
assign st = ~ins[31] & ins[30] & ~ins[29] & ins[28] & ~ins[27] & ins[26];

assign block_bit = ~(ld_fb | jmp | jmp_cond);
assign block_bus = {block_bit,block_bit,block_bit,block_bit,block_bit,block_bit,block_bit,block_bit,block_bit,block_bit,block_bit,block_bit,block_bit,block_bit,block_bit};
assign ins_block = ins[25:11] & block_bus;

assign mem_en_ld = ld & ~mem_en_ld_dec;
assign mem_en_dec = mem_en_ld_dec | mem_en_st_dec;
assign mem_mux_sel_dec = ~mem_rw_dec & mem_en_dec;

assign RA_comp_ex = (RA_dec == RW_ex) ? 1'b1 : 1'b0;
assign RA_comp_dm = (RA_dec == RW_dm) ? 1'b1 : 1'b0;
assign RA_comp_wb = (RA_dec == RW_wb) ? 1'b1 : 1'b0;

assign RB_comp_ex = (RB_dec == RW_ex) ? 1'b1 : 1'b0;
assign RB_comp_dm = (RB_dec == RW_dm) ? 1'b1 : 1'b0;
assign RB_comp_wb = (RB_dec == RW_wb) ? 1'b1 : 1'b0;

assign mux_sel_A = (RA_comp_ex == 1'b1) ? 2'b01 : ((RA_comp_dm == 1'b1) ? 2'b10 : ((RA_comp_wb == 1'b1) ? 2'b11 : 2'b00));
assign mux_sel_B = (RB_comp_ex == 1'b1) ? 2'b01 : ((RB_comp_dm == 1'b1) ? 2'b10 : ((RB_comp_wb == 1'b1) ? 2'b11 : 2'b00));

assign imm_temp = (reset == 1'b0)? 8'b0 : ins[15:0];
assign RA_dec_temp = (reset == 1'b0)? 5'b0 : ins_block[9:5];
assign RB_dec_temp = (reset == 1'b0)? 5'b0 : ins_block[4:0];
assign RW_dec_temp = (reset == 1'b0)? 5'b0 : ins_block[14:10];
assign RW_ex_temp = (reset == 1'b0)? 5'b0 : RW_dec;
assign RW_dm_temp = (reset == 1'b0)? 5'b0 : RW_ex;
assign RW_wb_temp = (reset == 1'b0)? 5'b0 : RW_dm;
assign op_dec_temp = (reset == 1'b0)? 6'b0 : ins[31:26];
assign ld_fb_temp = (reset == 1'b0)? 1'b0 : ld_with_fb;
assign mem_rw_dec_temp = (reset == 1'b0)? 1'b0 : ins[26];
assign mem_en_ld_dec_temp = (reset == 1'b0)? 1'b0 : mem_en_ld;
assign mem_en_st_dec_temp = (reset == 1'b0)? 1'b0 : st;
assign mem_rw_ex_temp = (reset == 1'b0)? 1'b0 : mem_rw_dec;
assign mem_mux_sel_ex_temp = (reset == 1'b0)? 1'b0 : mem_mux_sel_dec;
assign mem_en_ex_temp = (reset == 1'b0)? 1'b0 : mem_en_dec;
assign mem_mux_sel_dm_temp = (reset == 1'b0)? 1'b0 : mem_mux_sel_ex;
assign imm_sel_temp = (reset == 1'b0)? 1'b0 : immediate;

always@(posedge clk)
begin
	imm <= imm_temp;
	RA_dec <= RA_dec_temp;
	RB_dec <= RB_dec_temp;
	RW_dec <= RW_dec_temp;
	RW_ex <= RW_ex_temp;
	RW_dm <= RW_dm_temp;
	RW_wb <= RW_wb_temp;
	op_dec <= op_dec_temp;
	ld_fb <= ld_fb_temp;
	mem_rw_dec <= mem_rw_dec_temp;
	mem_en_ld_dec <= mem_en_ld_dec_temp;
	mem_en_st_dec <= mem_en_st_dec_temp;
	mem_rw_ex <= mem_rw_ex_temp;
	mem_mux_sel_ex <= mem_mux_sel_ex_temp;
	mem_en_ex <= mem_en_ex_temp;
	mem_mux_sel_dm <= mem_mux_sel_dm_temp;
	imm_sel <= imm_sel_temp;
end

endmodule
