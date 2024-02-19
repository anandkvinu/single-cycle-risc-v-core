module reg_file(WE3,A1,A2,A3,WD3,RD1,RD2,clk,rst);

    input [4:0] A1,A2,A3;
    input [31:0] WD3;
    input rst,clk;
    input WE3;

    output [31:0] RD1,RD2;

    //  memory

    reg [31:0] registers [31:0];

    assign RD1 = (!rst) ? 32'h00000000 : registers[A1];

    assign RD2 = (!rst) ? 32'h00000000 : registers[A2];
    
always @(posedge clk ) begin
    if(WE3)
    begin
        registers[A3] <= WD3; 
    end
end

endmodule