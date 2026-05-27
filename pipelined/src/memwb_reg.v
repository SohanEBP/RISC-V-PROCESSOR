module MEM_WB_Reg(
    input clk,
    input [63:0] MEM_ALUResult, readdata, 
    input [4:0] MEM_Rd,
    input MEM_MemtoReg,
    input MEM_RegWrite,
    output reg [63:0] WB_ReadData, WB_ALUResult,
    output reg [4:0] WB_Rd,
    output reg WB_MemtoReg,
    output reg WB_RegWrite
);

    // Initialize all registers to 0
    initial begin
        WB_ReadData = 0;
        WB_ALUResult = 0;
        WB_Rd = 0;
        WB_MemtoReg = 0;
        WB_RegWrite = 0;
    end

    always @(posedge clk) begin
        WB_ReadData <= readdata;
        WB_ALUResult <= MEM_ALUResult;
        WB_Rd <= MEM_Rd;
        WB_MemtoReg <= MEM_MemtoReg;
        WB_RegWrite <= MEM_RegWrite;
    end
endmodule
