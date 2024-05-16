module mux4x1_test;

reg in1, in2, in3, in4;
reg sel1, sel0;
wire out;

mux4x1 
uut(.in1(in1), .in2(in2), .in3(in3), .in4(in4), .sel1(sel1), .sel0(sel0), .out(out));

initial begin
  $dumpfile("build/mux4x1.vcd");
  $dumpvars(0, mux4x1_test);

  //Apply inputs and check the output
  in1 =  0; in2 =  0; in3 =  0; in4 =  0; sel1 =  0; sel0 =  0; #10; //Output in1
  in1 =  1; in2 =  1; in3 =  0; in4 =  0; sel1 =  0; sel0 =  1; #10; //Output in2
  in1 =  0; in2 =  1; in3 =  0; in4 =  0; sel1 =  1; sel0 =  0; #10; //Output in3
  in1 =  0; in2 =  0; in3 =  1; in4 =  1; sel1 =  1; sel0 =  1; #10; //Output in4

  $finish();
end

endmodule
