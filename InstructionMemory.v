`timescale 1ns / 1ps

module InstructionMemory(

	input [31:0] PCLine,
	output reg [31:0] Instruction
    );


	reg [7:0] Ins [0:255];
//reg [31:0] Ins_1 [0:63];

	
	// get head instruction
	initial begin
		$readmemb ("instructions.txt", Ins);
	end
	
	
	//get next instruction
	always@(PCLine) begin
//	Instruction = Ins_1[PCLine >> 2];
		Instruction [31:24] <= Ins[PCLine];
		Instruction [23:16] <= Ins[PCLine+1];
		Instruction [15:8] <= Ins[PCLine+2];
		Instruction [7:0] <= Ins[PCLine+3];
	end


endmodule
