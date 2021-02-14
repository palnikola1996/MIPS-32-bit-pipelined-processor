`timescale 1ns / 1ps
//----------------------------------------------------------------------
//Created by :- Pal Nikola, Dharm Patel, Rushiraj Yadav
//Module Name :- Main Module Test Bench
//----------------------------------------------------------------------

module MIPS_main_module_tb;

	// Inputs
	reg [15:0] data_in;
	reg interrupt;
	reg clk;
	reg reset;

	// Outputs
	wire [15:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	MIPS_main_module uut (
		.data_out(data_out), 
		.data_in(data_in), 
		.interrupt(interrupt), 
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		data_in = 0;
		interrupt = 0;
		clk = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#20;
        
		reset = 0;
		
		#50;
		
		reset = 1;

	end
      always 
		#50	clk = ~clk;
      
endmodule

