module counter(
  input clk, input reset,
  input load, input [15:0] load_val,
  output reg [15:0] count
);

initial count = 4'b0000;

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