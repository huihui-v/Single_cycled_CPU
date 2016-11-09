`timescale 1ns / 1ps

module ControlUnit(
	input [5:0]Op, 
	input zero, 
	output PCWre, 
	output ALUSrcB, 
	output ALUM2Reg, 
	output RegWre,
	output InsMemRw, 
	output RD, 
	output WR, 
	output ExtSel, 
	output RegDst, 
	output [2:0] ALUOp, 
	output PCSrc
    );
	parameter _add=6'b000000, _addi=6'b000001, _sub=6'b000010, _ori=6'b010000,
				 _and=6'b010001, _or=6'b010010, _move=6'b100000, _sw=6'b100110,
				 _lw=6'b100111, _beq=6'b110000, _halt=6'b111111;
	
	reg ADD, ADDI, SUB, ORI, AND, OR, MOVE, SW, LW, BEQ, HALT;
	
	always@(Op) begin
		ADD = 0;
		ADDI = 0;
		SUB = 0;
		ORI = 0;
		AND = 0;
		OR = 0;
		MOVE = 0;
		SW = 0;
		LW = 0;
		BEQ = 0;
		HALT = 0;
		
		case(Op)
			_add: ADD = 1;
			_addi: ADDI = 1;
			_sub: SUB = 1;
			_ori: ORI = 1;
			_and: AND = 1;
			_or: OR = 1;
			_move: MOVE = 1;
			_sw: SW = 1;
			_lw: LW = 1;
			_beq: BEQ = 1;
			_halt: HALT = 1;
		endcase
	end
		
	assign PCWre = !HALT;
	assign ALUSrcB = ADDI || ORI || SW || LW;
	assign ALUM2Reg = LW;
	assign RegWre = !(SW || BEQ || HALT);
	assign InsMemRw = 0;
	assign RD = !SW;
	assign WR = !LW;
	assign ExtSel = ADDI || SW || LW || BEQ;
	assign RegDst = ADD || SUB || AND || OR || MOVE;
	assign ALUOp = {AND, ORI || OR, SUB || ORI || OR || BEQ};
	assign PCSrc = BEQ && zero;
	
endmodule
