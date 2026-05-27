module alu_control_module(
    input [2:0] func3,
    input func7,
    input [1:0] aluop,
    output reg [3:0] alu_code
);

    always @(*) begin
        case (aluop)
            2'b00: alu_code = 4'b0010; // ADD (for load/store instructions)
            2'b01: alu_code = 4'b0110; // SUB (for branch instructions)
            2'b10: begin
                case (func3)
                    3'b000: alu_code = (func7 == 1'b1) ? 4'b0110 : 4'b0010; // ADD/SUB  (for Rtype instructions)
                    3'b110: alu_code = 4'b0001; // OR
                    3'b111: alu_code = 4'b0000; // AND
                endcase
            end
            default: alu_code = 4'b0000; // default case
        endcase
    end

endmodule