`timescale 1ns / 1ps

module RegisterFile(
	input [4:0] rs, 
	input [4:0] rt, 
	input [4:0] rd, 
	input [31:0] write_data, 
	input clk, 
	input RegDst, 
	input RegWre,
	output [31:0] read_data1, 
	output [31:0] read_data2
    );
	reg [31:0] register [0:31];

	integer i;
	initial begin

		for (i = 0; i < 32; i = i+1)
			register[i] <= 0;
	end
	
	assign read_data1 = (rs == 0)?0:register[rs];
	assign read_data2 = (rt == 0)?0:register[rt];
	
	always@(negedge clk) begin
		if (RegWre == 1) begin
			if ((RegDst == 1)&&(rd != 0)) begin
				$display("write rd");
				register[rd] <= write_data;
			end
			else if ((RegDst == 0)&&(rt != 0)) begin
				$display("write rt")	;
				register[rt] <= write_data;
			end
		end
	end

endmodule
