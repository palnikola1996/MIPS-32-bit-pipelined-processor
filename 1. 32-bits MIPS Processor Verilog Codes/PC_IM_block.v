`timescale 1ns / 1ps
//----------------------------------------------------------------------
//Created by :- Pal Nikola, Dharm Patel, Rushiraj Yadav
//Module Name :-  Program Counter & Instruction Memory
//----------------------------------------------------------------------

module PC_IM_block(ins, current_address, jmp_loc, pc_mux_sel, stall, stall_pm, clk, reset);

output [31:0] ins;
output [15:0] current_address;

input [15:0] jmp_loc;
input pc_mux_sel, stall, stall_pm, clk, reset;

wire [31:0] ins_pm, PM_out;
wire [31:0] PM_out_temp, ins_prv_temp;
wire [15:0] CAJ, CAR;
wire [15:0] hold_address_temp, next_address_temp;
	 
reg [31:0] ins_prv;
reg [15:0] hold_address, next_address;

Program_Memory PMem (
  .clka(clk), 
  .addra(current_address), 
  .douta(PM_out) 
);

assign CAJ = stall ? hold_address : next_address;
assign CAR = pc_mux_sel ? jmp_loc : CAJ;
assign current_address = reset ? CAR : 16'b0;

assign ins_prv_temp = reset ? ins : 32'b0;
assign hold_address_temp = reset ? current_address : 16'b0;
assign next_address_temp = reset ? current_address+1'b1 : 16'b0;

always@(posedge clk)
begin
	ins_prv <= ins_prv_temp;
	hold_address <= hold_address_temp;
	next_address <= next_address_temp;
end

assign ins_pm = stall_pm ? ins_prv : PM_out;
assign ins = reset ? ins_pm : 32'b0;

endmodule
