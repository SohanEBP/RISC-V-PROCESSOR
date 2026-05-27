module IF_ID_Reg (
    input wire clk,
    input wire [63:0] IF_PC,
    input wire [31:0] IF_Instruction,
    input IF_ID_Write,
    input flush,
    output reg [63:0] ID_PC,          // Declare as wire
    output reg [31:0] ID_Instruction  // Declare as wire
);
    initial begin
        ID_PC=0;
        ID_Instruction=0;
    end
    // Assign outputs to internal regs
    always @(posedge clk, posedge flush) begin
        if (flush) begin
            ID_PC<=0;
            ID_Instruction<=0;
        end
        else if(IF_ID_Write == 1'b1)
        begin
            ID_PC<= IF_PC;
            ID_Instruction <= IF_Instruction; 
        end
    end
endmodule