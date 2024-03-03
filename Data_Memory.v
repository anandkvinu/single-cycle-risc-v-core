module Data_mem(WE,WD,A,clk,rst,RD);
    input WE;
    input clk,rst;
    input [31:0] A,WD;

    output [31:0] RD;

    reg [31:0] data_mem [1023:0] ;

    assign RD = (~rst) ? 32'd0 : data_mem[A];
    always @(posedge clk ) begin
        if(WE)
        
            data_mem[A] <= WD;
    
    end
initial
begin
 data_mem[28]= 32'h00000030;
end

endmodule
