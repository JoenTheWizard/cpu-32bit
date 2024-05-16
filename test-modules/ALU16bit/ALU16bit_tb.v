module ALU16bit_test;

reg [15:0] a;
reg [15:0] b;
reg sel0, sel1;
wire [15:0] out;

ALU16bit uut(a,b,sel0,sel1,out);

initial begin
    $dumpfile("build/ALU16bit.vcd"); //Assume in 'build' directory
    $dumpvars(0, ALU16bit_test);

    //Apply inputs and check the output
    a =  20; b =  38; sel1 =  0; sel0 =  0; #10; //Output in1
    a =  8; b =  5; sel1 =  0; sel0 =  1; #10; //Output in2
    a =  5; b =  4; sel1 =  1; sel0 =  0; #10; //Output in3
    a =  6; b =  3; sel1 =  1; sel0 =  1; #10; //Output in4    

    $finish();
end

endmodule