`include "P_C.v"
`include "Instruction_Memory.v"
`include "Register_files.v"
`include "sign_extend.v"
`include "ALU.v"
`include "Control_Unit_top.v"
`include "Data_Memory.v"
`include "PC_Adder.v"

module Single_Cycle_Top(clk,rst);

    input clk,rst;

    wire [31:0] PC_Top,RD_Instr,RD1_Top,Imm_Ext_Top,ALUResult_Top,Read_data,PCPlus4;
    wire RegWrite;
    wire [2:0] ALUControl_Top;


    p_c pcobj(
        .clk(clk),
        .rst(rst),
        .PC(PC_Top),
        .PC_NEXT(PCPlus4)
    );
    pc_adder add(
    .a(PC_Top),
    .b(32'd4),
    .c(PCPlus4)
 );

    instruction_memory Instmemobj(
        .rst(rst),
        .A(PC_Top),
        .RD(RD_Instr)
    );
    reg_file regfileobj(
        .clk(clk),
        .rst(rst),
        .WE3(RegWrite),
        .A1(RD_Instr[19:15]),
        .A2(),
        .A3(RD_Instr[11:7]),
        .WD3(Read_data),
        .RD1(),
        .RD2()
        
    );

Sign_Extend signextendobj(
    .In(RD_Instr),
    .Imm_Ext()
);


alu aluobj(
    .A(RD1_Top),
    .B(Imm_Ext_Top),
    .alucontrol(ALUControl_Top),
    .result(ALUResult_Top),
    .Z(),
    .N(),
    .V(),
    .C()
);

control_unit_top ctrltopobj(
    .PCSrc(),
    .ResultSrc(),
    .MemWrite(),
    .ALUControl(ALUControl_Top),
    .ALUSrc(),
    .ImmSrc(),
    .RegWrite(),
    .Op(RD_Instr[6:0]),
    .funct3(RD_Instr[14:12]),
    .funct7(),
    .zero()
);
 Data_mem data_memobj(
    .clk(clk),
    .rst(rst),
    .A(ALUResult_Top),
    .RD(Read_data),
    .WE(),
    .WD()
    
    
 );

 

endmodule