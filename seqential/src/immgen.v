module immGenerator (
    input wire [31:0] instr,
    output reg [63:0] immOut
);
    always @(*) begin
        case (instr[6:0])
            7'b0010011, 7'b0000011: immOut = {{52{instr[31]}}, instr[31:20]};
            7'b0100011: immOut = {{52{instr[31]}}, instr[31:25], instr[11:7]};
            7'b1100011: immOut = {{51{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
            default: immOut = 64'b0;
        endcase
    end
endmodule