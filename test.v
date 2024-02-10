module sr_latch
(
   input wire S,
   input wire R,
   output wire Q,
   output wire Q_n
);

//NOR gates to assign Q and Q not
assign Q = ~(R | Q_n);
assign Q_n = ~(S | Q);

endmodule
