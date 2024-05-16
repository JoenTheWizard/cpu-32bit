module cpu_test;

reg clk = 0, reset;

cpu uut(
    .clk(clk),
    .reset(reset)
);

always #1 clk = ~clk; //every 1 cycle

initial begin
    $dumpfile("cpu.vcd"); //Assume in 'build' directory
    $dumpvars(0, cpu_test);

    reset = 1;
    @(posedge clk);
    reset = 0;

    #20

    $finish();
end

endmodule