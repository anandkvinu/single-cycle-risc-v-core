`include "Alu_decoder.v"
`include "Main_Decoder.v"


module control_unit_top(PCSrc,ResultSrc,MemWrite,ALUControl,ALUSrc,ImmSrc,RegWrite,Op,funct3,funct7,zero);


input [2:0] funct3;
input [6:0] Op,funct7;
input zero;

output [1:0] ImmSrc;
output [2:0] ALUControl;
output RegWrite,ALUSrc,MemWrite,ResultSrc,PCSrc;

wire [1:0]ALUOp;

alu_decoder aludcoderobj(

    .ALUOp(ALUOp),
    .op5(),
    .funct3(funct3),
    .funct7(funct7),
    .ALUControl(ALUControl)

);
main_decoder maindcdrobj(

    .op(Op),
    .zero(zero),
    .RegWrite(RegWrite),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .ALUSrc(ALUSrc),
    .ImmSrc(ImmSrc),
    .ALUOp(ALUOp),
    .PCSrc(PCSrc)
);


endmodule