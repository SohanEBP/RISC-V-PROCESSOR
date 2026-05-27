module alu_control_module(
    input [2:0] funct3,
    input funct7,
    input [1:0] aluop,      // 2-bit ALU operation code from control unit
    output reg [3:0] alu_code       // 4-bit ALU control signal
);

    always @(*) begin
        case (aluop)
            2'b00: alu_code = 4'b0010; // ADD (for load/store instructions)
            2'b01: alu_code = 4'b0011; // SUB (for branch instructions)
            2'b10: begin
                case (funct3)
                    3'b000: alu_code = (funct7 == 1'b1) ? 4'b0011 : 4'b0010; // ADD/SUB (for R-type instructions)
                    3'b110: alu_code = 4'b0001; // OR
                    3'b111: alu_code = 4'b0000; // AND
                    default: alu_code = 4'b0000; // default case
                endcase
            end
            default: alu_code = 4'b0000; // default case
        endcase
    end

endmodule