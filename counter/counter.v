module counter(
  input clk, 
  input load, input [3:0] load_val,
  output reg [3:0] count
);

initial count = 4'b0000;

//assign count = 0;
always @(posedge clk) begin
  if (load) begin
    count <= load_val;
  end else begin
    count <= count + 1;
  end
end

endmodule;
