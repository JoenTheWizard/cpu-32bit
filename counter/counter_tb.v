module counter_test;

reg clk = 0, load = 0;
//reg load =  0;
reg [3:0] load_val =  4'b0000;
wire [3:0] count;

counter uut(.clk(clk), .load(load), .load_val(load_val), .count(count));

always #1 clk = ~clk; //every 1 cycle

initial begin
    $dumpfile("build/counter.vcd"); //Assume in 'build' directory
    $dumpvars(0, counter_test);
   
    //Simulate control unit
    load_val = 4'h7;
    #11
    load = 1;
    #1 load = 0;

    //Simulate control unit
    load_val = 4'h4;
    #11
    load = 1;
    #1 load = 0;

    #50

    $finish();
end

endmodule
