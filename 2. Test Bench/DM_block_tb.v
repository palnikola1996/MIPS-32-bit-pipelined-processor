`timescale 1ns / 1ps
//----------------------------------------------------------------------
//Created by :- Pal Nikola, Dharm Patel, Rushiraj Yadav
//Module Name :- Data Memory Test Bench
//----------------------------------------------------------------------

module DM_block_tb;

	// Inputs
	reg [15:0] ans_ex;
	reg [15:0] DM_data;
	reg mem_en_ex;
	reg mem_rw_ex;
	reg mem_mux_sel_dm;
	reg clk;
	reg reset;

	// Outputs
	wire [15:0] ans_dm;

	// Instantiate the Unit Under Test (UUT)
	DM_block uut (
		.ans_dm(ans_dm), 
		.ans_ex(ans_ex), 
		.DM_data(DM_data), 
		.mem_en_ex(mem_en_ex), 
		.mem_rw_ex(mem_rw_ex), 
		.mem_mux_sel_dm(mem_mux_sel_dm), 
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		ans_ex = 16'h0003;
		DM_data = 16'hFFFF;
		mem_en_ex = 0;
		mem_rw_ex = 0;
		mem_mux_sel_dm = 0;
		clk = 0;
		reset = 1'b1;

		// Wait 100 ns for global reset to finish
		#2 reset = 1'b0;
		
		#6 reset = 1'b1;
       
		#2 mem_en_ex = 1'b1; mem_mux_sel_dm = 1'b1;	
		
		#10 mem_rw_ex = 1'b1; 
		
		#10 mem_rw_ex = 1'b0; 
		
		// Add stimulus here

	end
	always
		#5 clk = ~clk;
      
endmodule

