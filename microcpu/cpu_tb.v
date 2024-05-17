module cpu_test;

reg clk = 0, reset;

cpu uut(
    .clk(clk),
    .reset(reset)
);

always #1 clk = ~clk; //every 1 cycle

initial begin
    $dumpfile("build/cpu.vcd"); //Assume in 'build' directory
    $dumpvars(0, cpu_test);

    reset = 1;
    #2
    reset = 0;

    #20

    $finish();
end

endmodule
