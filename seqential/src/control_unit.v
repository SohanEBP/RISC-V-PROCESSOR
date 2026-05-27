module ControlUnit (
    input [6:0] opcode,     
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
            7'b0000011: begin // load 
                ALUSrc = 1;
                MemtoReg = 1;
                RegWrite = 1;
                MemRead = 1;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 2'b00;
            end
            7'b0100011: begin // store 
                ALUSrc = 1;
                MemtoReg = 0; // dont care
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 1;
                Branch = 0;
                ALUOp = 2'b00;
            end
            7'b1100011: begin // branch beq
                ALUSrc = 0;
                MemtoReg = 0; // don't care
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 1;
                ALUOp = 2'b01;
            end
            default: begin // default (NO OP)
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
