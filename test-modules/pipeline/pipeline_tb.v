module pipeline_test;

reg clk;
reg flush;
reg [7:0] a;
reg [7:0] b;
wire [8:0] result;

pipeline uut(
  .clk(clk),
  .flush(flush),
  .a(a),
  .b(b),
  .result(result)
);

//Clock
always #1 clk = ~clk;

initial begin
    $dumpfile("build/pipeline.vcd"); //Assume in 'build' directory
    $dumpvars(0, pipeline_test);

    clk = 0; flush = 1;
    a = 0; b = 0;

    #4

    flush = 0;

    #2 

    //Test Case 1: Simple addition
    a = 8'h03; b = 8'h02;

    #4

    flush = 1;

    #2

    flush = 0;

    $finish();
end

endmodule
