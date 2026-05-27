module ControlUnit (
    input [6:0] opcode,     // 7-bit opcode 
    
    // control signals 
    output reg ALUSrc,      
    output reg MemtoReg,    
    output reg RegWrite,    
    output reg MemRead,     
    output reg MemWrite,    
    output reg Branch,      
    output reg [1:0] ALUOp 
);

    always @(*) begin
        case (opcode)
            7'b0110011: begin // R-Type (ADD, SUB, AND, OR, etc.)
                ALUSrc = 0;
                MemtoReg = 0;
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 2'b10;
            end
            7'b0000011: begin // load (LW)
                ALUSrc = 1;
                MemtoReg = 1;
                RegWrite = 1;
                MemRead = 1;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 2'b00;
            end
            7'b0100011: begin // store (SW)
                ALUSrc = 1;
                MemtoReg = 0; // don't care
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 1;
                Branch = 0;
                ALUOp = 2'b00;
            end
            7'b1100011: begin // branch (BEQ)
                ALUSrc = 0;
                MemtoReg = 0; // don't care
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 1;
                ALUOp = 2'b01;
            end
            7'b0010011: begin // I-Type (ADDI, etc.)
                ALUSrc = 1; // Use immediate value
                MemtoReg = 0; // Result comes from ALU
                RegWrite = 1; // Write to register
                MemRead = 0; // No memory read
                MemWrite = 0; // No memory write
                Branch = 0; // No branch
                ALUOp = 2'b00; // ALU performs addition
            end
            default: begin // default (invalid opcode)
                ALUSrc = 0;
                MemtoReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 2'b00;
            end
        endcase
    end

endmodule