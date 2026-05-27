// module immGenerator (
//     input wire [31:0] instr,    // 32-bit instruction
//     output reg [63:0] immOut    // 64-bit immediate value
// );
//     always @(*) begin
//         case (instr[6:0])       // sign extension
//             7'b0010011, 7'b0000011: immOut = {{52{instr[31]}}, instr[31:20]};   // I-type (ALU immediate, load)
//             7'b0100011: immOut = {{52{instr[31]}}, instr[31:25], instr[11:7]};  // S-type (store)
//             7'b1100011: immOut = {{51{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};   // SB-type (branch)
//             default: immOut = 64'b0;
//         endcase
//     end
// endmodule
module immGenerator (
    input  wire [31:0] instr, // 32-bit instruction
    output reg  [63:0] immOut     // 64-bit immediate data
);

  always @(*) begin
    case (instr[6:0]) 
      // I-type instructions (Load, Immediate ALU, JALR)
      7'b0000011, 7'b0010011, 7'b1100111: begin
        immOut = {{52{instr[31]}}, instr[31:20]}; // Sign-extended
      end

      // S-type instructions (Store)
      7'b0100011: begin
        immOut = {{52{instr[31]}}, instr[31:25], instr[11:7]}; // Sign-extended
      end

      // B-type instructions (Branch)
      7'b1100011: begin
        immOut = {{52{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0}; // Sign-extended
      end

      // Default case to prevent undefined behavior
      default: begin
        immOut = 64'b0;
      end
    endcase
  end

endmodule