`timescale 1ns / 1ps
//----------------------------------------------------------------------
//Created by :- Pal Nikola, Dharm Patel, Rushiraj Yadav
//Module Name :- Execution Block
//----------------------------------------------------------------------

module Ex_block(data_out, ans_ex, DM_data, flag_ex, data_in, A, B, op_dec, clk, reset);

input [15:0] data_in, A, B;
input [5:0] op_dec;
input clk, reset;

output reg [15:0] data_out, ans_ex, DM_data;
output [1:0] flag_ex;

wire [15:0] B_not, B_temp, add_sub, ans_ALU, data_out_buff, ar_shift_out;
wire [15:0] data_out_temp, ans_ex_temp, DM_data_temp;
wire [1:0] flag_prv_temp;
wire c_prv, c_final, Z, V;

reg [1:0] flag_prv;

assign B_not = ~B;
assign B_temp = op_dec[0] ? B_not : B;
assign {c_prv,add_sub[14:0]} = A[14:0] + B_temp[14:0] + op_dec[0];
assign {c_final,add_sub[15]} = A[15] + B_temp[15] + c_prv;

arithmetic_right ar (ar_shift_out, A, B[3:0]);

assign ans_ALU = (op_dec == 6'b000000) ? add_sub : 
						((op_dec == 6'b000001) ? add_sub :
						((op_dec == 6'b000010) ? B :
						((op_dec == 6'b000011) ? A*B :
						((op_dec == 6'b000100) ? A & B :
						((op_dec == 6'b000101) ? A | B :
						((op_dec == 6'b000110) ? A ^ B :
						((op_dec == 6'b000111) ? B_not :
						((op_dec == 6'b001000) ? add_sub : 
						((op_dec == 6'b001001) ? add_sub :
						((op_dec == 6'b001010) ? B :
						((op_dec == 6'b001100) ? A & B :
						((op_dec == 6'b001101) ? A | B :
						((op_dec == 6'b001110) ? A ^ B :
						((op_dec == 6'b001111) ? B_not :
						((op_dec == 6'b010000) ? ans_ex :
						((op_dec == 6'b010001) ? ans_ex :
						((op_dec == 6'b010100) ? A :
						((op_dec == 6'b010101) ? A :
						((op_dec == 6'b010110) ? data_in :
						((op_dec == 6'b010111) ? ans_ex :
						((op_dec == 6'b011000) ? ans_ex :
						((op_dec == 6'b011001) ? A<<B[3:0]:
						((op_dec == 6'b011010) ? A>>B[3:0] :
						((op_dec == 6'b011011) ? ar_shift_out :
						((op_dec == 6'b011100) ? ans_ex :
						((op_dec == 6'b011101) ? ans_ex:
						((op_dec == 6'b011110) ? ans_ex :
						((op_dec == 6'b011111) ? ans_ex : 16'b0
						))))))))))))))))))))))))))));
						
assign Z = ~|ans_ALU;
assign V = (c_prv ^ c_final) & ~op_dec[5] & ~op_dec[4]& ~op_dec[2]& ~op_dec[1];

assign flag_ex = (op_dec == 6'b000000) ? {Z,V} : 
						((op_dec == 6'b000001) ? {Z,V} :
						((op_dec == 6'b000010) ? {Z,V} :
						((op_dec == 6'b000010) ? {Z,1'b0} :
						((op_dec == 6'b000100) ? {Z,V} :
						((op_dec == 6'b000101) ? {Z,V} :
						((op_dec == 6'b000110) ? {Z,V} :
						((op_dec == 6'b000111) ? {Z,V} :
						((op_dec == 6'b001000) ? {Z,V} : 
						((op_dec == 6'b001001) ? {Z,V} :
						((op_dec == 6'b001010) ? {Z,V} :
						((op_dec == 6'b001100) ? {Z,V} :
						((op_dec == 6'b001101) ? {Z,V} :
						((op_dec == 6'b001110) ? {Z,V} :
						((op_dec == 6'b001111) ? {Z,V} :
						((op_dec == 6'b010000) ? 2'b0 :
						((op_dec == 6'b010001) ? 2'b0 :
						((op_dec == 6'b010100) ? 2'b0 :
						((op_dec == 6'b010101) ? 2'b0 :
						((op_dec == 6'b010110) ? {Z,V} :
						((op_dec == 6'b010111) ? 2'b0 :
						((op_dec == 6'b011000) ? 2'b0 :
						((op_dec == 6'b011001) ? {Z,V} :
						((op_dec == 6'b011010) ? {Z,V} :
						((op_dec == 6'b011011) ? {Z,V} :
						((op_dec == 6'b011100) ? flag_prv :
						((op_dec == 6'b011101) ? flag_prv :
						((op_dec == 6'b011110) ? flag_prv :
						((op_dec == 6'b011111) ? flag_prv : 2'b0
						))))))))))))))))))))))))))));
						
assign data_out_buff = (op_dec == 6'b010111) ? A : data_out;

assign data_out_temp = reset ? data_out_buff : 16'b0;
assign ans_ex_temp = reset ? ans_ALU : 16'b0;
assign DM_data_temp = reset ? B : 16'b0;
assign flag_prv_temp = reset ? flag_ex : 2'b0;

always@(posedge clk)
begin
		data_out <= data_out_temp;
		ans_ex <= ans_ex_temp;
		DM_data <= DM_data_temp;
		flag_prv <= flag_prv_temp;
end 

endmodule

module arithmetic_right(shift_out, shift_in, shift_amount);

output [15:0] shift_out;

input signed [15:0] shift_in;
input [3:0] shift_amount;

assign shift_out = shift_in>>>shift_amount;

endmodule
