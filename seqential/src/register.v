module registerfile (
    input [4:0] Read1, Read2, WriteReg, 
    input [63:0] WriteData,             
    input RegWrite, clk,                 
    output [63:0] Data1, Data2            
);
    
    reg [63:0] RF [31:0];  // 32 registers, 64-bit each
    
    reg [63:0] tempData1, tempData2;
    
    integer k;
    initial begin
        for (k = 0; k < 32; k = k + 1) begin
            RF[k] = 64'd0;
        end
    end

    always @(*) begin
        tempData1 = RF[Read1];
        tempData2 = RF[Read2];
    end

    assign Data1 = tempData1;
    assign Data2 = tempData2;

    // writing to register file on posedge clock
    always @(posedge clk) begin
        if (RegWrite) 
            RF[WriteReg] <= WriteData;
    end
    
endmodule
