`timescale 1ns / 1ps

module my_cpu();

//defination of wires and regs
	reg [31:0] PCLine;
	reg clk;
	wire [31:0] Instruction;
	wire [5:0] Op;
	wire [4:0] rs;
	wire [4:0] rt;
	wire [4:0] rd;
	wire [15:0] immediate;
	wire zero;
	wire [31:0] extended_immediate;
	wire [31:0] result;
	wire [31:0] write_data;
	wire [31:0] read_data1;
	wire [31:0] read_data2;
	//wires of control unit
	wire PCWre;
	wire ALUSrcB;
	wire ALUM2Reg;
	wire RegWre;
	wire InsMemRW;
	wire RD;
	wire WR;
	wire ExtSel;
	wire RegDst;
	wire [2:0] ALUOp;
	wire PCSrc; //We will only consider the condition of two cases
//end of defination

	//PC initial
	initial begin
		PCLine = 0;
	end
	//end of PC initial
	

//clock
	initial begin
		clk = 0;
	end
	
	always #500
		clk = ~clk;
//end of clock

//data path

	InstructionMemory instructionmemory(PCLine, Instruction);
	//destruction of instruction
	assign Op = Instruction [31:26];
	assign rs = Instruction [25:21];
	assign rt = Instruction [20:16];
	assign rd = Instruction [15:11];
	assign immediate = Instruction [15:0];
	//end of destruction
	
	
	ControlUnit controlunit(Op, zero, PCWre, ALUSrcB, ALUM2Reg, RegWre,
	                         InsMemRw, RD, WR, ExtSel, RegDst, ALUOp, PCSrc);
	
	RegisterFile registerfile (rs, rt, rd, write_data, clk, RegDst, RegWre,
										read_data1, read_data2);
	
	Extend extend (immediate, ExtSel, extended_immediate);
	
	ALU alu (read_data1, read_data2, extended_immediate, ALUOp, ALUSrcB, zero, result);
	
	DataMemory datamemory (result, read_data2, RD, WR, ALUM2Reg, write_data);
	//PC refresh
	always@(posedge clk) begin
		if (PCWre == 0)
			PCLine <= PCLine;
		else begin
			if(PCSrc == 0)
				PCLine <= PCLine + 4;
			else
				PCLine <= PCLine + 4 + (extended_immediate<<2);
		end
	end
	//end of PC refresh
endmodule
