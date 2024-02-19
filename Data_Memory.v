module Data_mem(WE,WD,A,clk,rst,RD)
    input WE;
    input clk,rst;
    input [31:0] A,WD;

    output [31:0] RD;

    reg [31:0] data_mem [1023:0] ;

    assign RD = (WE == 1'b0) ? data_mem[A] : 32'h00000000;

    always @(posedge clk ) begin
        if(WE)
        begin
            data_mem[A] <= WD;
        end
    end


endmodule
