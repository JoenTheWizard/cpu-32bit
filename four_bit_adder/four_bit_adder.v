module four_bit_adder(
  input [3:0] a,
  input [3:0] b,
  output [3:0] sum,
  output carry_out
);

wire cout1, cout2, cout3;
full_adder h1(.a(a[0]), .b(b[0]), .cin(1'b0), .sum(sum[0]), .carry(cout1));
full_adder h2(.a(a[1]), .b(b[1]), .cin(cout1), .sum(sum[1]), .carry(cout2));
full_adder h3(.a(a[2]), .b(b[2]), .cin(cout2), .sum(sum[2]), .carry(cout3));
full_adder h4(.a(a[3]), .b(b[3]), .cin(cout3), .sum(sum[3]), .carry(carry_out));

endmodule
