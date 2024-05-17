module ALU16bit_test;

reg [15:0] a;
reg [15:0] b;
reg [3:0] func;
wire [15:0] out;

ALU16bit uut(a,b,func,out);

initial begin
    $dumpfile("build/ALU16bit.vcd"); //Assume in 'build' directory
    $dumpvars(0, ALU16bit_test);

    //Apply inputs and check the output
    a = 20; b = 38; func = 1; #10; //Output in1
    a =  8; b =  5; func = 2; #10; //Output in2
    a =  5; b =  4; func = 3; #10; //Output in3
    a =  6; b =  3; func = 4; #10; //Output in4    

    $finish();
end

endmodule
