`include "PC.v"
`include "Instuction_Memory.v"
`include "Register_files.v"
`include "sign_extend.v"
`include "ALU.v"
`include "Control_Unit_top.v"

module Single_Cycle_Top(clk,rst);

    input clk,rst;

    wire [31:0] PC_Top,RD_Instr,RD1_Top,Imm_Ext_Top,ALUControl_Top,ALUResult_Top;



    p_c pcobj(
        .clk(clk),
        .rst(rst),
        .PC(PC_Top),
        .PC_NEXT()
    );

    instruction_memory Instmemobj(
        .rst(rst),
        .A(PC_Top),
        .RD(RD_Instr)
    );
    reg_file regfileobj(
        .WE3(),
        .A1(RD_Instr[19:15]),
        .A2(),
        .A3(),
        .WD3(),
        .RD1(),
        .RD2(),
        .clk(clk),
        .rst(rst)
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
endmodule