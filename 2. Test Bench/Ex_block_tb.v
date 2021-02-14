`timescale 1ns / 1ps
//----------------------------------------------------------------------
//Created by :- Pal Nikola, Dharm Patel, Rushiraj Yadav
//Module Name :- Execution Block Test Bench
//----------------------------------------------------------------------

module Ex_block_tb;

	// Inputs
	reg [15:0] data_in;
	reg [15:0] A;
	reg [15:0] B;
	reg [5:0] op_dec;
	reg clk;
	reg reset;

	// Outputs
	wire [15:0] data_out;
	wire [15:0] ans_ex;
	wire [15:0] DM_data;
	wire [1:0] flag_ex;

	// Instantiate the Unit Under Test (UUT)
	Ex_block uut (
		.data_out(data_out), 
		.ans_ex(ans_ex), 
		.DM_data(DM_data), 
		.flag_ex(flag_ex), 
		.data_in(data_in), 
		.A(A), 
		.B(B), 
		.op_dec(op_dec), 
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		A = 16'h0040;
		B = 16'h00C0;
		data_in = 16'h0008;
		clk = 1'b0;
		reset = 1'b1;
		
		#2 reset = 1'b0;
		#5 reset = 1'b1;
		
		#3  op_dec = 6'b000000; //ADD
		#10 op_dec = 6'b000001; //SUB
		#10 op_dec = 6'b000010; //MOV
		#10 op_dec = 6'b000100; //AND
		#10 op_dec = 6'b000101; //OR
		#10 op_dec = 6'b000110; //XOR
		#10 op_dec = 6'b000111; //NOT
		
		#10 op_dec = 6'b001000; //ADI
		#10 op_dec = 6'b001001; //SBI
		#10 op_dec = 6'b001010; //MVI
		#10 op_dec = 6'b001100; //ANI
		#10 op_dec = 6'b001101; //ORI
		#10 op_dec = 6'b001110; //XORI
		#10 op_dec = 6'b001111; //NTI
		
		#10 op_dec = 6'b010000; //RET
		#10 op_dec = 6'b010001; //HLT
		#10 op_dec = 6'b010100; //ST
		#10 op_dec = 6'b010101; //LD
		#10 op_dec = 6'b010110; //IN
		#10 op_dec = 6'b010111; //OUT
		#10 op_dec = 6'b011000; //JMP
		
		#10 A = 16'h80C0;B = 16'h0001;
			 op_dec = 6'b011001; //LS
		#10 op_dec = 6'b011010; //RS
		#10 op_dec = 6'b011011; //RSA
		#10 op_dec = 6'b011100; //JC
		#10 op_dec = 6'b011101; //JNC
		#10 op_dec = 6'b011110; //JZ
		#10 op_dec = 6'b011111; //JNZ

		
		
	end
	always 
		#5 clk = ~clk;
      
endmodule

