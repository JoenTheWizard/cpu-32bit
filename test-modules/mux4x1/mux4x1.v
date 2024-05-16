module mux4x1(
  input in1, in2, in3, in4,
  input sel1, sel0,
  output out
);

//sel = 00, out = in1
//sel = 01, out = in2
//sel = 10, out = in3
//sel = 11, out = in4

assign out = (in1 & ~sel0 & ~sel1) | (in2 & sel0 & ~ sel1) | (in3 & ~sel0 & sel1) | (in4 & sel0 & sel1);

endmodule;
