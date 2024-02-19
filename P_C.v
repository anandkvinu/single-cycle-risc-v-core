module p_c(PC_NEXT,PC,rst,clk);

    input [31:0] PC_NEXT;
    input rst;
    input clk;

    output [31:0] PC;

    always @(posedge clk ) begin

        if(rst == 1'b0) 
        begin
          pc <= 32'h00000000;
        end

        else

        begin
         PC <=PC_NEXT;
        end
        
    end

endmodule