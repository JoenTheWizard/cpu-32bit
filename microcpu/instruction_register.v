module instruction_register(
  input             clk,
  input             flush,
  input      [31:0] in_instruction,

  output reg [31:0] out_instruction
);

always @(posedge clk or posedge flush) begin
  if (flush) begin
    out_instruction <= 32'b0;
  end else begin 
    out_instruction <= in_instruction;
  end
end

endmodule
