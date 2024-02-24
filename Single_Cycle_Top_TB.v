module Single_Cycle_Top_TB();

    reg clk,rst;

    Single_Cycle_Top single_cycle_top(
        .clk(clk),
        .rst(rst)
    );

    initial begin
        $dumpfile("single cycle.vcd");
        $dumpvars(0);
    end

    always
    begin
        clk = ~clk;
        #50;
    end


    initial
    begin
        rst = 1'b0;
        #150;
        

        rst =1'b1;
        #500;
        $finish;
    end
    
endmodule