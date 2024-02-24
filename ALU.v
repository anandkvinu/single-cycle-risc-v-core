module alu (A,B,alucontrol,result,Z,N,V,C);
    input [31:0] A,B;
    input [2:0] alucontrol;

    output [31:0] result;
    output Z,N,V,C;


    
    //deaclare logic wire for internal outputs of logic
    wire [31:0] a_and_b;
    wire [31:0] a_or_b;
    wire [31:0] not_b;
    wire [31:0] alu_mux1;
    wire [31:0] sum;
    wire [31:0] alu_mux2;
    wire [31:0] slt;
    wire  cout;

    //logic
    assign a_and_b = A & B;

    assign a_or_b = A | B;

    assign not_b = ~B;

    assign alu_mux1 = (alucontrol[0] == 1'b0) ? B :not_b;
    
    assign {cout,sum} = A + alu_mux1 + alucontrol[0];/// here the alu mux1 will be B if alucntrl is 0 
                                             ///and if 1 it will be the ones compliment of B + 1
                                             ///(control bit) which is twos compliment

    assign alu_mux2 = (alucontrol[2:0] == 3'b000) ? sum :
                      (alucontrol[2:0] == 3'b001) ? sum : 
                      (alucontrol[2:0] == 3'b010) ? a_and_b :
                      (alucontrol[2:0] == 3'b011) ? a_or_b :
                      (alucontrol[2:0] == 3'b101) ? slt : 32'h00000000;
    assign result = alu_mux2;
// f;ag

    assign Z = &(~A); // zero flag

    assign N = result[31];// 31 st big 1 or not

    assign C = cout &(~alucontrol[1]);//  carry flag

    assign V = (~alucontrol[1]) & (A[31] ^ sum[31] )& (A[31] ^ B[31] ^ alucontrol[1]);// overflow flag

    assign slt = {31'b0000000000000000000000000000000,sum[31]};
endmodule