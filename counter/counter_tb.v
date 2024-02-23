module counter_test;

reg clk = 0;
wire [3:0] count;

counter uut(.clk(clk), .count(count));

always #1 clk = ~clk; //every 1 sec

initial begin
    $dumpfile("build/counter.vcd"); //Assume in 'build' directory
    $dumpvars(0, counter_test);
    
    #50

    $finish();
end

endmodule
