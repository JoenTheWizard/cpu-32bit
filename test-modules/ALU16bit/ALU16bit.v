module ALU16bit(
  input [15:0] a, b,
  input sel0, sel1,
  output [15:0] out
);

//Operations
wire [15:0] operation1 = a + b;
wire [15:0] operation2 = a - b;
wire [15:0] operation3 = a & b;
wire [15:0] operation4 = a | b;

//assign out[0] =  (operation1[0] & (~sel0 & ~sel1)) | (operation2[0] & (sel0 & ~ sel1)) | (operation3[0] & (~sel0 & sel1)) | (operation4[0] & (sel0 & sel1));
//assign out[1] =  (operation1[1] & (~sel0 & ~sel1)) | (operation2[1] & (sel0 & ~ sel1)) | (operation3[1] & (~sel0 & sel1)) | (operation4[1] & (sel0 & sel1));
//assign out[2] =  (operation1[2] & (~sel0 & ~sel1)) | (operation2[2] & (sel0 & ~ sel1)) | (operation3[2] & (~sel0 & sel1)) | (operation4[2] & (sel0 & sel1));
//assign out[3] =  (operation1[3] & (~sel0 & ~sel1)) | (operation2[3] & (sel0 & ~ sel1)) | (operation3[3] & (~sel0 & sel1)) | (operation4[3] & (sel0 & sel1));

//Multiplexer
genvar i;
for (i = 0; i < 16; i=i+1) begin   
  assign out[i] =  (operation1[i] & (~sel0 & ~sel1)) | (operation2[i] & (sel0 & ~ sel1)) | (operation3[i] & (~sel0 & sel1)) | (operation4[i] & (sel0 & sel1));
end 

endmodule