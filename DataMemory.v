`timescale 1ns / 1ps

module DataMemory(
input [31:0] result, 
input [31:0] read_data2, 
input RD, 
input WR, 
input ALUM2Reg, 
output [31:0] write_data
    );
	reg [7:0] register [0:255];
	reg [31:0] data_stream;
	always@(RD or WR or result) begin
		if (RD == 1 && WR == 0) begin
			data_stream[31:24] = register[result<<2];
			data_stream[23:16] = register[(result<<2)+1];
			data_stream[15:8] = register[(result<<2)+2];
			data_stream[7:0] = register[(result<<2)+3];			
		end
		else if (RD == 0 && WR == 1) begin
			register[(result<<2)] = read_data2[31:24];
			register[(result<<2)+1] = read_data2[23:16];
			register[(result<<2)+2] = read_data2[15:8];
			register[(result<<2)+3] = read_data2[7:0];
		end
	end
	assign write_data = (ALUM2Reg)?data_stream:result;

endmodule
