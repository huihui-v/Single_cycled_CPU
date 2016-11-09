`timescale 1ns / 1ps

module ALU( 
    input [31:0] read_data1,
    input [31:0] read_data2,
    input [31:0] extended_immediate,
    input [2:0] ALUOp,
	 input ALUSrcB,
    output wire zero,
    output reg [31:0] result
    );

    wire [31:0] alub;

    assign alub = (ALUSrcB == 0) ? read_data2 : extended_immediate;

    always@( read_data1 or alub or ALUOp) begin
       $display("here");
        case (ALUOp)
            3'b000: result <= read_data1 + alub;
            3'b001: result <= read_data1 - alub;
            3'b010: result <= alub - read_data1;
            3'b011: result <= read_data1 | alub;
            3'b100: result <= read_data1 & alub;
            3'b101: result <= ~read_data1 & alub;
            3'b110: result <= (~read_data1 & alub) | (read_data1 & ~alub);
            3'b111: result <= (read_data1 & alub) | (~read_data1 & ~alub);
        endcase

        end
        assign zero = (result == 0) ? 1 : 0;

endmodule
