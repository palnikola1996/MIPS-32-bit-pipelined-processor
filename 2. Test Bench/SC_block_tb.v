`timescale 1ns / 1ps
//----------------------------------------------------------------------
//Created by :- Pal Nikola, Dharm Patel, Rushiraj Yadav
//Module Name :- Stall Control Block Test Bench
//----------------------------------------------------------------------


module SC_block_tb;

	// Inputs
	reg [5:0] op;
	reg clk;
	reg reset;

	// Outputs
	wire stall;
	wire stall_pm;

	// Instantiate the Unit Under Test (UUT)
	SC_block uut (
		.stall(stall), 
		.stall_pm(stall_pm), 
		.op(op), 
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		op = 6'b000000;
		clk = 1'b0;
		reset = 1'b1;

		#2;
        
		reset = 1'b0;
		
		#6
		
		reset = 1'b1;
		
		#8
		
		op = 6'b010100;
		
		#20
		
		op = 6'b000000;
		
		#10
		
		op = 6'b011110;
		
		#30
		
		op = 6'b000000;
		
		#10
		
		op = 6'b010001;

	end
	
	always
		#5 clk = ~clk;
      
endmodule

