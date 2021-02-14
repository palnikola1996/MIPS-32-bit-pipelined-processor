`timescale 1ns / 1ps
//----------------------------------------------------------------------
//Created by :- Pal Nikola, Dharm Patel, Rushiraj Yadav
//Module Name :- Jump Control Block Test Bench
//----------------------------------------------------------------------

module JC_block_tb;

	// Inputs
	reg [15:0] current_address;
	reg [15:0] jmp_address_pm;
	reg [5:0] op;
	reg [1:0] flag_ex;
	reg interrupt;
	reg clk;
	reg reset;

	// Outputs
	wire [15:0] jmp_loc;
	wire pc_mux_sel;

	// Instantiate the Unit Under Test (UUT)
	JC_block uut (
		.jmp_loc(jmp_loc), 
		.pc_mux_sel(pc_mux_sel), 
		.current_address(current_address), 
		.jmp_address_pm(jmp_address_pm), 
		.op(op), 
		.flag_ex(flag_ex), 
		.interrupt(interrupt), 
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		current_address = 16'h0001;
		jmp_address_pm = 16'h0000;
		op = 6'b000000;
		flag_ex = 2'b11;
		interrupt = 1'b0;
		clk = 1'b0;
		reset = 1'b1;

		#2;
        
		reset = 1'b0;
		
		#6;
		
		reset = 1'b1;
		
		#8;
		
		interrupt = 1'b1;
		
		#10;
		
		jmp_address_pm = 16'h0008;
		interrupt = 1'b0;
		
		#10;
		
		op = 6'b011000;
		
		#20; 
		
		op = 6'b010000;
		flag_ex = 2'b00;
		
		#10;
		
		op = 6'b011110;

	end
	
	always
		#5 clk = ~clk;
      
endmodule

