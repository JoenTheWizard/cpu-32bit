module full_adder_test;

reg a, b, cin;
wire sum, carry;

full_adder uut(a, b, cin, sum, carry);

initial begin
  $dumpfile("build/full_adder.vcd");
  $dumpvars(0, full_adder_test);

  cin = 0;
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
