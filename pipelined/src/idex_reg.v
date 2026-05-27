module ID_EX_Reg(
    input clk,
    input [63:0] ID_PC,
    input [63:0] ID_ReadData1,
    input [63:0] ID_ReadData2,
    input [63:0] ID_Immediate,
    input [4:0] ID_Rs1,
    input [4:0] ID_Rs2,
    input [4:0] ID_Rd,
    input ID_ALUSrc,
    input ID_MemtoReg,
    input ID_RegWrite,
    input ID_MemRead,
    input ID_MemWrite,
    input ID_Branch,
    input [1:0] ID_ALUOp,
    input [2:0] func3,
    input func7,
    input flush,
    output reg [63:0] EX_PC,
    output reg [63:0] EX_ReadData1,
    output reg [63:0] EX_ReadData2,
    output reg [63:0] EX_Immediate,
    output reg [4:0] EX_Rs1,
    output reg [4:0] EX_Rs2,
    output reg [4:0] EX_Rd,
    output reg EX_ALUSrc,
    output reg EX_MemtoReg,
    output reg EX_RegWrite,
    output reg EX_MemRead,
    output reg EX_MemWrite,
    output reg EX_Branch,
    output reg [1:0] EX_ALUOp,
    output reg [2:0] EX_func3,
    output reg EX_func7
);
    // Initialize all registers to 0
    initial begin
        EX_PC = 0;
        EX_ReadData1 = 0;
        EX_ReadData2 = 0;
        EX_Immediate = 0;
        EX_Rs1 = 0;
        EX_Rs2 = 0;
        EX_Rd = 0;
        EX_ALUSrc = 0;
        EX_MemtoReg = 0;
        EX_RegWrite = 0;
        EX_MemRead = 0;
        EX_MemWrite = 0;
        EX_Branch = 0;
        EX_ALUOp = 0;
        EX_func3 = 0;
        EX_func7 = 0;
    end

    always @(posedge clk,posedge flush) begin
        if(flush) begin
        EX_ALUSrc <= 1'b0;
        EX_MemtoReg <= 1'b0;
        EX_RegWrite <= 1'b0;
        EX_MemRead <= 1'b0;
        EX_MemWrite <= 1'b0;
        EX_Branch <= 1'b0;
        EX_ALUOp <= 2'b00;
        EX_PC <= 64'b0;
        EX_ReadData1 <= 64'b0;
        EX_ReadData2 <= 64'b0;
        EX_Immediate <= 64'b0;
        EX_Rs1 <= 5'b0;
        EX_Rs2 <= 5'b0;
        EX_Rd <= 5'b0;
        EX_func7 <= 1'b0;
        EX_func3 <= 3'b0;
        end
        else begin
            EX_ALUSrc <= ID_ALUSrc;
        EX_MemtoReg <= ID_MemtoReg;
        EX_RegWrite <= ID_RegWrite;
        EX_MemRead <= ID_MemRead;
        EX_MemWrite <= ID_MemWrite;
        EX_Branch <= ID_Branch;
        EX_ALUOp <= ID_ALUOp;
        EX_PC <= ID_PC;
        EX_ReadData1 <= ID_ReadData1;
        EX_ReadData2 <= ID_ReadData2;
        EX_Immediate <= ID_Immediate;
        EX_Rs1 <= ID_Rs1;
        EX_Rs2 <= ID_Rs2;
        EX_Rd <= ID_Rd;
        EX_func7 <= func7;
        EX_func3 <= func3;
        end
    end
endmodule