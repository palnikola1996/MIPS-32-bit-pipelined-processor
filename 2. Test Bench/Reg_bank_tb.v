`timescale 1ns / 1ps
//----------------------------------------------------------------------
//Created by :- Pal Nikola, Dharm Patel, Rushiraj Yadav
//Module Name :- Register Bank Test Bench
//----------------------------------------------------------------------

module Reg_bank_tb;

	// Inputs
	reg [15:0] ans_ex;
	reg [15:0] ans_dm;
	reg [15:0] ans_wb;
	reg [15:0] imm;
	reg [4:0] RA;
	reg [4:0] RB;
	reg [4:0] RW_dm;
	reg [1:0] mux_sel_A;
	reg [1:0] mux_sel_B;
	reg imm_sel;
	reg clk;

	// Outputs
	wire [15:0] A;
	wire [15:0] B;

	// Instantiate the Unit Under Test (UUT)
	Reg_bank uut (
		.A(A), 
		.B(B), 
		.ans_ex(ans_ex), 
		.ans_dm(ans_dm), 
		.ans_wb(ans_wb), 
		.imm(imm), 
		.RA(RA), 
		.RB(RB), 
		.RW_dm(RW_dm), 
		.mux_sel_A(mux_sel_A), 
		.mux_sel_B(mux_sel_B), 
		.imm_sel(imm_sel), 
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		RW_dm = 5'b00111;
		ans_ex = 16'hC000;
		ans_dm = 16'hD000;
		ans_wb = 16'hE000;
		RA = 5'b00101;
		RB = 5'b00110;
		imm = 16'hFFFF;
		mux_sel_A = 2'b00;
		mux_sel_B = 2'b00;
		imm_sel = 1'b1;
		clk = 1'b0;
		
	#10; RB = 5'b00111; mux_sel_B = 2'b01; imm_sel = 1'b0;
	#5; mux_sel_A = 2'b10;
	#5; mux_sel_A = 2'b11; mux_sel_B = 2'b00;
		
		
	end
	
	always
		#5 clk = ~clk;
      
endmodule

