module EX_MEM_Reg(
    input clk,
    input [63:0] EX_PC,
    input [63:0] EX_ALUResult,
    input [63:0] EX_ReadData2,
    input [4:0] EX_Rd,
    input EX_MemtoReg,
    input EX_RegWrite,
    input EX_MemRead,
    input EX_MemWrite,
    input EX_Branch,
    input EX_Zero,
    output reg [63:0] MEM_PC,
    output reg [63:0] MEM_ALUResult,
    output reg [63:0] MEM_ReadData2,
    output reg [4:0] MEM_Rd,
    output reg MEM_MemtoReg,
    output reg MEM_RegWrite,
    output reg MEM_MemRead,
    output reg MEM_MemWrite,
    output reg MEM_Branch,
    output reg MEM_Zero
);

    // Initialize all registers to 0
    initial begin
        MEM_PC = 0;
        MEM_ALUResult = 0;
        MEM_ReadData2 = 0;
        MEM_Rd = 0;
        MEM_MemtoReg = 0;
        MEM_RegWrite = 0;
        MEM_MemRead = 0;
        MEM_MemWrite = 0;
        MEM_Branch = 0;
        MEM_Zero = 0;
    end

    always @(posedge clk) begin
        MEM_PC <= EX_PC;
        MEM_ALUResult <= EX_ALUResult;
        MEM_ReadData2 <= EX_ReadData2;
        MEM_Rd <= EX_Rd;
        MEM_MemtoReg <= EX_MemtoReg;
        MEM_RegWrite <= EX_RegWrite;
        MEM_MemRead <= EX_MemRead;
        MEM_MemWrite <= EX_MemWrite;
        MEM_Branch <= EX_Branch;
        MEM_Zero <= EX_Zero;
    end
endmodule
