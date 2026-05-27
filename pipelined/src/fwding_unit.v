module ForwardingUnit (
    input [4:0] EX_rs1,
    input [4:0] EX_rs2,
    input [4:0] MEM_rd,
    input [4:0] WB_rd,
    input MEM_RegWrite,
    input WB_RegWrite,
    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB
);
    always @(*) begin
        // ForwardA
        if (MEM_RegWrite && (MEM_rd != 0) && (MEM_rd == EX_rs1))
            ForwardA = 2'b10;
        else if (WB_RegWrite && (WB_rd != 0) && (WB_rd == EX_rs1))
            ForwardA = 2'b01;
        else
            ForwardA = 2'b00;

        // ForwardB
        if (MEM_RegWrite && (MEM_rd != 0) && (MEM_rd == EX_rs2))
            ForwardB = 2'b10;
        else if (WB_RegWrite && (WB_rd != 0) && (WB_rd == EX_rs2))
            ForwardB = 2'b01;
        else
            ForwardB = 2'b00;
    end
endmodule