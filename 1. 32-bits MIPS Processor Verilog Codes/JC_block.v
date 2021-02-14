`timescale 1ns / 1ps
//----------------------------------------------------------------------
//Created by :- Pal Nikola, Dharm Patel, Rushiraj Yadav
//Module Name :- Jump Control Block
//----------------------------------------------------------------------

module JC_block(jmp_loc, pc_mux_sel, current_address, jmp_address_pm, op, flag_ex, interrupt, clk, reset);

output [15:0] jmp_loc;
output pc_mux_sel;

input [15:0] current_address, jmp_address_pm;
input [5:0] op;
input [1:0] flag_ex;
input interrupt, clk, reset;

wire [15:0] address_mux, jmp_address;
wire [15:0] address_prv_temp;
wire [1:0] flag_current, flag_mux;
wire [1:0] flag_prv_temp;
wire jz, jnz, jv, jnv, jmp, ret, pc_mux_sel_jz, pc_mux_sel_jnz, pc_mux_sel_jv, pc_mux_sel_jnv;
wire int_ff1_temp, int_ff2_temp;

reg [15:0] address_prv;
reg [1:0] flag_prv;
reg int_ff1, int_ff2;

assign jz = (~op[5]) & (op[4]) & (op[3]) & (op[2]) & (op[1]) & (~op[0]);
assign jnz = (~op[5]) & (op[4]) & (op[3]) & (op[2]) & (op[1]) & (op[0]);
assign jv = (~op[5]) & (op[4]) & (op[3]) & (op[2]) & (~op[1]) & (~op[0]);
assign jnv = (~op[5]) & (op[4]) & (op[3]) & (op[2]) & (~op[1]) & (op[0]);
assign jmp = (~op[5]) & (op[4]) & (op[3]) & (~op[2]) & (~op[1]) & (~op[0]);
assign ret = (~op[5]) & (op[4]) & (~op[3]) & (~op[2]) & (~op[1]) & (~op[0]);

assign pc_mux_sel_jz = (flag_current[1]) & jz;
assign pc_mux_sel_jnz = (~flag_current[1]) & jnz;
assign pc_mux_sel_jv = (flag_current[0]) & jv;
assign pc_mux_sel_jnv = (~flag_current[0]) & jnv;

assign pc_mux_sel = pc_mux_sel_jz | pc_mux_sel_jnz |pc_mux_sel_jv |pc_mux_sel_jnv | jmp | int_ff1 | ret;

assign flag_current = (ret == 1'b1) ? flag_prv : flag_ex;
assign flag_mux = (int_ff2 == 1'b1) ? flag_ex : flag_prv;

assign address_mux = (interrupt == 1'b1) ? (current_address+16'h0001) : address_prv;
assign jmp_address = (int_ff1 == 1'b1) ? 16'hF000 : jmp_address_pm;
assign jmp_loc = (ret == 1'b1) ? address_prv : jmp_address;

assign flag_prv_temp = (reset == 1'b1) ? flag_mux : 2'b0;
assign int_ff1_temp = (reset == 1'b1) ? interrupt : 1'b0;
assign int_ff2_temp = (reset == 1'b1) ? int_ff1 : 1'b0;
assign address_prv_temp = (reset == 1'b1) ? address_mux : 16'b0;

always@(posedge clk)
begin
	flag_prv <= flag_prv_temp;
	int_ff1 <= int_ff1_temp;
	int_ff2 <= int_ff2_temp;
	address_prv <= address_prv_temp;
end

endmodule
