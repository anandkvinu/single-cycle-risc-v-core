module instruction_memory(A,RD,rst);

    input[31:0] A;
    input rst;

    reg [31:0] mem [1023:0];
    
    output [31:0] RD;

    assign RD = (rst == 1'b0) ? 32'h00000000 : mem[A[31:2]];

    initial begin
        mem[0] = 32'hFFC4A303;
    end

endmodule