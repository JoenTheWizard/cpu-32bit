module half_adder_test;

reg a, b;
wire sum, carry;

half_adder uut(a, b, sum, carry);

initial begin
  $dumpfile("build/half_adder.vcd");
  $dumpvars(0, half_adder_test);

  a = 0; b = 0;
  #10
  a = 0; b = 1;
  #10
  a = 1; b = 0;
  #10
  a = 1; b = 1;
  #10
  $finish();
end

endmodule
