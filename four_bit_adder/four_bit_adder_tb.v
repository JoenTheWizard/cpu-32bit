module four_bit_adder_test;

reg [3:0] a; 
reg [3:0] b;
reg cin;
wire [3:0] sum;
wire carry_out;

four_bit_adder uut(a, b, sum, carry_out);

initial begin
  $dumpfile("build/four_bit_adder.vcd");
  $dumpvars(0, four_bit_adder_test);

  cin = 0;
  a = 10; b = 4;
  #10
  a = 5; b = 3;
  #10
  a = 9; b = 9;
  #10
  a = 2; b = 4;
  #10
  $finish();
end

endmodule
