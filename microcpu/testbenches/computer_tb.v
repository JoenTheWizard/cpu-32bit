module computer_test;

reg clk = 0, reset;

computer uut(
    .clk(clk),
    .reset(reset)
);

always #1 clk = ~clk; //every 1 cycle

initial begin
    $dumpfile("build/computer.vcd"); //Assume in 'build' directory
    $dumpvars(0, computer_test);

    reset = 1;
    #2
    reset = 0;

    #40

    $finish();
end

endmodule
