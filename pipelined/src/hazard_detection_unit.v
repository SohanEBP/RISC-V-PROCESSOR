module HazardDetectionUnit (
    input [4:0] ID_rs1,
    input [4:0] ID_rs2,
    input [4:0] EX_rd,
    input EX_MemRead,
    output reg PCWrite,
    output reg IF_ID_Write,
    output reg ControlMux
);
    always @(*) begin
        if (EX_MemRead && ((EX_rd == ID_rs1) || (EX_rd == ID_rs2))) begin
            PCWrite = 0;
            IF_ID_Write = 0;
            ControlMux = 1;
        end else begin
            PCWrite = 1;
            IF_ID_Write = 1;
            ControlMux = 0;
        end
    end
endmodule