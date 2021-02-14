`timescale 1ns / 1ps
//----------------------------------------------------------------------
//Created by :- Pal Nikola, Dharm Patel, Rushiraj Yadav
//Module Name :- Program Counter & Instruction Memory Test Bench
//----------------------------------------------------------------------

module PC_IM_tb;

	// Inputs
	reg [15:0] jmp_loc;
	reg pc_mux_sel;
	reg stall;
	reg stall_pm;
	reg clk;
	reg reset;

	// Outputs
	wire [31:0] ins;
	wire [15:0] current_address;

	// Instantiate the Unit Under Test (UUT)
	PC_IM_block uut (
		.ins(ins), 
		.current_address(current_address), 
		.jmp_loc(jmp_loc), 
		.pc_mux_sel(pc_mux_sel), 
		.stall(stall), 
		.stall_pm(stall_pm), 
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		jmp_loc = 16'h0008;
		clk = 0;
		stall = 0;
		stall_pm = 0;
		reset = 1'b1;
		pc_mux_sel = 1'b1;
		#2 
		
		reset = 1'b0;
		
		#6
		
		reset = 1'b1;
		
		#2;
		
		pc_mux_sel = 1'b0;
		
		#30;
       
		stall = 1'b1;
		// Add stimulus here
	   #10;

		stall = 1'b0;
		stall_pm = 1'b1;
		
		#10;
		
		pc_mux_sel = 1'b1;
		stall_pm = 1'b0;
		
	end
	
     always 
		#5 clk = ~clk;
      
endmodule

