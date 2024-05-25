module counter(
  input clk, input reset,
  input load, input [25:0] load_val,
  output reg [25:0] count
);

always @(posedge clk) begin
  if (reset) begin
    count <= 0;
  end
  else begin
    if (load) begin
      count <= load_val;
    end else begin
      count <= count + 1;
    end
  end
end

endmodule