module alu(
    input signed [63:0] source_1, source_2,
    input [3:0] alu_code,
    output signed [63:0] result,
    output overflow,
    output zero
);

    reg signed [63:0] result_reg;
    reg overflow_reg;
    reg zero_flag_reg;

    // ALU operations
    always @(*) begin
        case (alu_code)
            4'b0000: result_reg = source_1 & source_2; // AND
            4'b0001: result_reg = source_1 | source_2; // OR
            4'b0010: result_reg = source_1 + source_2; // ADD
            4'b0011: result_reg = source_1 - source_2; // SUB
            default: result_reg = 64'b0;      // default
        endcase
    end

    // Overflow logic
    always @(*) begin
        case (alu_code)
            4'b0010: overflow_reg = (source_1[63] == source_2[63]) && (result_reg[63] != source_1[63]); // ADD overflow
            4'b0011: overflow_reg = (source_1[63] != source_2[63]) && (result_reg[63] != source_1[63]); // SUB overflow
            default: overflow_reg = 1'b0; // no overflow for AND/OR
        endcase
    end

    // zero flag
    assign zero = (result_reg == 64'b0);

    // outputs
    assign result = result_reg;
    assign overflow = overflow_reg;

endmodule