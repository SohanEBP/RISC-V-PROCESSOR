`include "alu.v"
`include "control_unit.v"
`include "alu_control.v"
`include "data.v"
`include "instruction.v"
`include "pc.v"
`include "register.v"
`include "immgen.v"

module main_wrap(input clk);

    reg [63:0] pc_add;
    wire [63:0] next_pc_add;
    initial begin
        pc_add <= 64'b0;
    end

    wire ALUsrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch;

    wire [4:0] rs1,rs2,rd;

    wire [31:0] instruct;
    wire [6:0] opcode;
    wire [63:0] immediate,Readdata,read1,read2,write_data, alu_result,source2;
    wire [2:0] func3;
    wire [1:0] aluop;
    wire zero, overflow;
    wire [3:0] alu_control;

    assign opcode = instruct[6:0];
    assign func3 = instruct[14:12];
    assign rs1 = instruct[19:15];
    assign rs2 = instruct[24:20];
    assign rd = instruct[11:7];

    ControlUnit ControlUnit_uut(
        .opcode(opcode),
        .ALUSrc(ALUsrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUOp(aluop)
    );

    alu_control_module alu_control_module_uut(
        .func3(func3),
        .func7(instruct[30]),
        .aluop(aluop),
        .alu_code(alu_control)
    );
    wire branch_imm;
    and and1(branch_imm, Branch, zero);

    pc_address_generator pc_address_generator_uut(
        .nxt_pc_address(next_pc_add),
        .pc_add(pc_add),
        .immd(immediate),
        .branch(Branch)
    );

    instruction_module instruction_module_uut(
        .address(pc_add),
        .instruction(instruct)
    );

    immGenerator immGenerator_uut(
        .instr(instruct),
        .immOut(immediate)
    );

    registerfile registerfile_uut(
        .Read1(rs1),
        .Read2(rs2),
        .WriteReg(rd),
        .WriteData(write_data),
        .RegWrite(RegWrite),
        .clk(clk),
        .Data1(read1),
        .Data2(read2)
    );
    
    data_mem data_mem_uut(
        .out(Readdata),
        .add(alu_result),
        .in(read2),
        .mem_wr(MemWrite),
        .mem_rd(MemRead),
        .clk(clk)
    );

    genvar k;
    generate
        for (k = 0;k<64 ;k=k+1 ) begin
            mux_2x1 muxxing(.sel(ALUsrc),.in0(read2[k]),.in1(immediate[k]),.out(source2[k]));
        end
    endgenerate

    genvar a;
    generate
        for (a = 0;a<64 ;a=a+1 ) begin
            mux_2x1 muxxing(.sel(ALUsrc),.in0(alu_result[a]),.in1(Readdata[a]),.out(write_data[a]));
        end
    endgenerate

    alu alu_uut(
        .source_1(read1),
        .source_2(source2),
        .alu_code(alu_control),
        .result(alu_result),
        .zero(zero),
        .overflow(overflow)
    );

    always @(posedge clk) begin
        pc_add <= next_pc_add;
    end

endmodule

module mux_2x1 (
    input wire sel,      
    input wire in0,      
    input wire in1,      
    output wire out      
);

    assign out = sel ? in1 : in0;  

endmodule