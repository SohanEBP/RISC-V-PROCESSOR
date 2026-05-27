module alu(
    input signed [63:0] rs1, rs2,       // input operands
    input [3:0] alu_code,               // control signal to select ALU operation
    output signed [63:0] result,        // output of ALU operation
    output overflow,                    // indicates if an overflow occurred
    output zero                         // indicates if the result is zero
);

    reg signed [63:0] result_reg;
    reg overflow_reg;
    reg zero_flag_reg;

    // ALU operations
    always @(*) begin
        case (alu_code)
            4'b0000: result_reg = rs1 & rs2; // AND
            4'b0001: result_reg = rs1 | rs2; // OR
            4'b0010: result_reg = rs1 + rs2; // ADD
            4'b0011: result_reg = rs1 - rs2; // SUB
            default: result_reg = 64'b0;      // default
        endcase
    end

    // Overflow logic
    always @(*) begin
        case (alu_code)
            4'b0010: overflow_reg = (rs1[63] == rs2[63]) && (result_reg[63] != rs1[63]); // ADD overflow
            4'b0011: overflow_reg = (rs1[63] != rs2[63]) && (result_reg[63] != rs1[63]); // SUB overflow
            default: overflow_reg = 1'b0; // no overflow for AND/OR
        endcase
    end

    // zero flag
    assign zero = (result_reg == 64'b0);

    // outputs
    assign result = result_reg;
    assign overflow = overflow_reg;

always @(*) begin
    $display("Time = %0t | rs1 = %h | rs2 = %h | alu_code = %b", $time, rs1, rs2, alu_code);
end

endmodule