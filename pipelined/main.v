`include "alu.v"
`include "control_unit.v"
`include "alu_control.v"
`include "data.v"
`include "instruction.v"
`include "pc.v"
`include "register.v"
`include "immgen.v"
`include "ifid_reg.v"
`include "idex_reg.v"
`include "exmem_reg.v"
`include "memwb_reg.v"
`include "hazard_detection_unit.v"
`include "fwding_unit.v"
`include "branch_prediction.v"

module main_wrap(input clk);

    // All wire declaration
    wire [63:0] next_pc_add;    // next pc value
    wire ALUsrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch; // control signals
    wire [4:0] rs1, rs2, rd;    // register addresses
    wire [31:0] instruct;       // instruction fetched from memory
    wire [6:0] opcode;
    wire [63:0] immediate, readdata, read1, read2, write_data, alu_result, source2;
    wire [63:0] ID_PC;
    wire [31:0] ID_Instruction;
    wire [63:0] EX_PC;
    wire [31:0] EX_Instruction;
    wire [63:0] EX_ReadData1;
    wire [63:0] EX_ReadData2;
    wire [63:0] EX_Immediate;
    wire [4:0] EX_Rs1;
    wire [4:0] EX_Rs2;
    wire [4:0] EX_Rd;
    wire EX_ALUSrc;
    wire EX_MemtoReg;
    wire EX_RegWrite;
    wire EX_MemRead;
    wire EX_MemWrite;
    wire EX_Branch;
    wire [2:0] EX_func3;
    wire EX_func7;
    wire [1:0] EX_ALUOp;
    wire [1:0] ForwardA, ForwardB;
    wire [63:0] alu_source1, alu_source2;
    wire [63:0] MEM_PC;
    wire [63:0] MEM_ALUResult;
    wire [63:0] MEM_ReadData2;
    wire [4:0] MEM_Rd;
    wire MEM_MemtoReg;
    wire MEM_RegWrite;
    wire MEM_MemRead;
    wire MEM_MemWrite;
    wire MEM_Branch;
    wire MEM_Zero;
    wire PCsrc; 
    wire [63:0] WB_PC;
    wire [31:0] WB_Instruction;
    wire [63:0] WB_ALUResult;
    wire [63:0] WB_ReadData;
    wire [4:0] WB_Rd;
    wire WB_MemtoReg;
    wire WB_RegWrite;   
    wire [63:0] pc_imm;
    wire PCWrite, IF_ID_Write, ControlMux,PCWrite_inter;


    // All reg declaration
    reg [63:0] pc_add;          // current pc value
    wire [63:0] inter_pc;


    // Initialize pc_add on reset
    assign pc_imm = pc_add+64'd4; 
    initial begin
        pc_add <= 64'b0;
        // inter_pc <= 64'b0;
    end
    always @(posedge clk) begin
        if(PCWrite == 1'b1) begin
            pc_add <= inter_pc;  
        end
    end

    mux_2x1_64bit pc_mux(.sel(PCsrc), .in0(pc_imm), .in1(MEM_PC), .out(inter_pc));

    instruction_module instruction_module_uut(   // fetches instruction from memory based on curr pc value
        .address(pc_add),
        .instruction(instruct)
    );

    IF_ID_Reg IF_ID_Reg_uut(    
        .clk(clk),
        .IF_PC(pc_add),
        .IF_Instruction(instruct),
        .IF_ID_Write(IF_ID_Write),
        .ID_PC(ID_PC),
        .ID_Instruction(ID_Instruction),
        .flush (PCsrc)
    );

/*****************************************************************************************************************/ 

    // immediate: sign extended immediate value from imm gen
    // readdata: data read from memory
    // read1, read2: data read from register file
    // write_data: data to be written to register file
    // alu_result: result of ALU operation
    // source2: second source for ALU operation (can be immediate or readdata)

    wire [2:0] funct3;
    wire [1:0] aluop;
    wire zero, overflow;        // ALU flags
    wire [3:0] alu_control;

    assign opcode = ID_Instruction[6:0];
    assign funct3 = ID_Instruction[14:12];
    assign rs1 = ID_Instruction[19:15];
    assign rs2 = ID_Instruction[24:20];
    assign rd = ID_Instruction[11:7];

    ControlUnit ControlUnit_uut(   // decodes opcode and generates control s/gs
        .opcode(opcode),
        .ALUSrc(ALUsrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUOp(aluop)
    );
    wire ALUsrc_final, MemtoReg_final, RegWrite_final, MemRead_final, MemWrite_final, Branch_final;
    wire [1:0] aluop_final;

    assign ALUsrc_final = (ControlMux) ? 1'b0 : ALUsrc;
    assign MemtoReg_final = (ControlMux) ? 1'b0 : MemtoReg;
    assign RegWrite_final = (ControlMux) ? 1'b0 : RegWrite;
    assign MemRead_final = (ControlMux) ? 1'b0 : MemRead;
    assign MemWrite_final = (ControlMux) ? 1'b0 : MemWrite;
    assign Branch_final = (ControlMux) ? 1'b0 : Branch;
    assign aluop_final = (ControlMux) ? 2'b00 : aluop;

    registerfile registerfile_uut(  // contains registers and handles read and write
        .Read1(rs1),
        .Read2(rs2),
        .WriteReg(WB_Rd),
        .WriteData(final_write_data), 
        .RegWrite(WB_RegWrite), 
        .clk(clk),
        .Data1(read1),
        .Data2(read2)
    );

    immGenerator immGenerator_uut(  // extracts imm from instruction and generates sign extended immediate value
        .instr(ID_Instruction),
        .immOut(immediate)
    );

    ID_EX_Reg ID_EX_Reg_uut(    
        .clk(clk),
        .ID_PC(ID_PC),
        .ID_ReadData1(read1),
        .ID_ReadData2(read2),
        .ID_Immediate(immediate),
        .ID_Rs1(rs1),
        .ID_Rs2(rs2),
        .ID_Rd(rd), 
        .ID_ALUSrc(ALUsrc_final),
        .ID_MemtoReg(MemtoReg_final),
        .ID_RegWrite(RegWrite_final),
        .ID_MemRead(MemRead_final),
        .ID_MemWrite(MemWrite_final),
        .ID_Branch(Branch_final),
        .ID_ALUOp(aluop_final),
        .func3(funct3),
        .func7(ID_Instruction[30]),
        .EX_PC(EX_PC),
        .EX_ReadData1(EX_ReadData1),
        .EX_ReadData2(EX_ReadData2),
        .EX_Immediate(EX_Immediate),
        .EX_Rs1(EX_Rs1),
        .EX_Rs2(EX_Rs2),
        .EX_Rd(EX_Rd),
        .EX_ALUSrc(EX_ALUSrc),
        .EX_MemtoReg(EX_MemtoReg),
        .EX_RegWrite(EX_RegWrite),
        .EX_MemRead(EX_MemRead),
        .EX_MemWrite(EX_MemWrite),
        .EX_Branch(EX_Branch),
        .EX_ALUOp(EX_ALUOp),
        .EX_func3(EX_func3),
        .EX_func7(EX_func7),
        .flush(PCsrc)
    );

/*****************************************************************************************************************/ 

    ForwardingUnit ForwardingUnit_uut(  // forwards data to ALU
        .EX_rs1(EX_Rs1),
        .EX_rs2(EX_Rs2),
        .MEM_rd(MEM_Rd), 
        .WB_rd(WB_Rd), 
        .MEM_RegWrite(MEM_RegWrite),
        .WB_RegWrite(WB_RegWrite),
        .ForwardA(ForwardA),
        .ForwardB(ForwardB)
    );
    wire [63:0] final_write_data, MEM_alu_result;
    mux_3x1 forwardA(ForwardA, EX_ReadData1, final_write_data, MEM_alu_result, alu_source1);

    wire [63:0] buffer;

    mux_3x1 forwardB(ForwardB, EX_ReadData2, final_write_data, MEM_alu_result, buffer);

    mux_2x1_64bit mux_bhai(EX_ALUSrc, buffer, EX_Immediate, alu_source2);

    alu_control_module alu_control_module_uut(  // generates ALU control s/gs
        .funct3(EX_func3),
        .funct7(EX_func7),
        .aluop(EX_ALUOp),
        .alu_code(alu_control)
    );

    alu alu_uut(
        .rs1(alu_source1),
        .rs2(alu_source2),
        .alu_code(alu_control),
        .result(alu_result),
        .zero(zero),
        .overflow(overflow)
    );

    wire [63:0] pc_plus4;
    assign pc_plus4 = EX_Immediate + EX_PC;

    EX_MEM_Reg EX_MEM_Reg_uut(  
        .clk(clk),
        .EX_PC(pc_plus4),
        .EX_ALUResult(alu_result),
        .EX_ReadData2(buffer),
        .EX_Rd(EX_Rd),
        .EX_MemtoReg(EX_MemtoReg),
        .EX_RegWrite(EX_RegWrite),
        .EX_MemRead(EX_MemRead),
        .EX_MemWrite(EX_MemWrite),
        .EX_Branch(EX_Branch),
        .EX_Zero(zero),
        .MEM_PC(MEM_PC),
        .MEM_ALUResult(MEM_alu_result),
        .MEM_ReadData2(MEM_ReadData2),
        .MEM_Rd(MEM_Rd),
        .MEM_MemtoReg(MEM_MemtoReg),
        .MEM_RegWrite(MEM_RegWrite),
        .MEM_MemRead(MEM_MemRead),
        .MEM_MemWrite(MEM_MemWrite),
        .MEM_Branch(MEM_Branch),
        .MEM_Zero(MEM_Zero)
    );

/*****************************************************************************************************************/ 

    data_mem data_mem_uut(  //handles memory read and write
        .out(readdata),
        .add(MEM_alu_result),
        .in(MEM_ReadData2),
        .mem_wr(MEM_MemWrite),
        .mem_rd(MEM_MemRead),
        .clk(clk)
    );

    and and1(PCsrc, MEM_Branch, MEM_Zero);  // branch condition
    
    MEM_WB_Reg MEM_WB_Reg_uut(  
        .clk(clk),
        .MEM_ALUResult(MEM_alu_result),
        .readdata(readdata),
        .MEM_Rd(MEM_Rd),
        .MEM_MemtoReg(MEM_MemtoReg),
        .MEM_RegWrite(MEM_RegWrite),
        .WB_ReadData(WB_ReadData),
        .WB_ALUResult(WB_ALUResult),
        .WB_Rd(WB_Rd),
        .WB_MemtoReg(WB_MemtoReg),
        .WB_RegWrite(WB_RegWrite)
    );

/*****************************************************************************************************************/ 

    mux_2x1_64bit mux_behen(WB_MemtoReg, WB_ALUResult, WB_ReadData, final_write_data);


    // Hazard detection unit
    HazardDetectionUnit HazardDetectionUnit_uut(
            .EX_MemRead(EX_MemRead),
            .EX_rd(EX_Rd),
            .ID_rs2(rs2),
            .ID_rs1(rs1),
            .PCWrite(PCWrite),
            .IF_ID_Write(IF_ID_Write_inter),
            .ControlMux(ControlMux)
    );

    wire PCsrc_not;
not n1(PCsrc_not,PCsrc);
and (IF_ID_Write,IF_ID_Write_inter,PCsrc_not);
endmodule
module mux_2x1_64bit (
    input wire sel,              // 1-bit selection signal
    input wire [63:0] in0,       // 64-bit input 0
    input wire [63:0] in1,       // 64-bit input 1
    output wire [63:0] out       // 64-bit output
);
    assign out = sel ? in1 : in0;  // Select in1 if sel is 1, else select in0
endmodule

module mux_3x1 (
    input wire [1:0] sel,        // 2-bit selection signal
    input wire [63:0] in0,       // 64-bit input 0
    input wire [63:0] in1,       // 64-bit input 1
    input wire [63:0] in2,       // 64-bit input 2
    output wire [63:0] out       // 64-bit output
);
    assign out = (sel == 2'b00) ? in0 : 
                 (sel == 2'b01) ? in1 : 
                 (sel == 2'b10) ? in2 : 
                 64'b0;  // Default case
endmodule