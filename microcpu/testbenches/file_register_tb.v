module file_register_test;

reg clk;
reg [4:0] src1, src2, dest;
reg [15:0] data_in;
wire [15:0] alu_out1;
wire [15:0] alu_out2;

file_register uut(
    .clk(clk),
    .src1(src1),
    .src2(src2),
    .dest(dest),
    .data_in(data_in),
    .alu_out1(alu_out1),
    .alu_out2(alu_out2)
);

always #1 clk = ~clk; //every 1 cycle

initial begin
    $dumpfile("build/file_register.vcd"); //Assume in 'build' directory
    $dumpvars(0, file_register_test);
    clk = 0;
    
    src1 = 3;
    src2 = 1;
    #20

    src1 = 5;
    src2 = 10;
    #10

    dest = 4;
    data_in = 16'h1234;
    #5

    $finish();
end

endmodule
