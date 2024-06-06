module counter(
  input clk, input reset,

  input load,   input [31:0] load_val,
  input alu_in, input [31:0] alu_val,

  output reg [31:0] count,
  output reg [31:0] count_next
);

reg [31:0] count_reg;

always @(posedge clk) begin
  if (reset) begin
    count_reg <= 0;
  end
  else begin
    if (load) begin
      count_reg <= load_val;
    end
    else if (alu_in) begin
      count_reg <= alu_val;
    end
    else begin
      count_reg <= count_reg + 1;
    end
    
    //count_reg <= (load) ? load_val : count_reg + 1;
  end
end

always @(*) begin
  count      <= count_reg;
  count_next <= count_reg + 1;
end

endmodule