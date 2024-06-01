module file_register(
  input clk,
  input [4:0] src1, src2, dest,
  input [31:0] alu_data_in, memory_in,

  input [25:0] pc_addr_in,

  input mem_data_in,
  input write_enable,
  input pc_next_enable,

  output wire [31:0] alu_out1,
  output wire [31:0] alu_out2
);

reg [31:0] regFile[0:31];

//Read from file to initialize the 16 registers
initial begin
    $readmemh("readmem/registers.mem", regFile);
end

assign alu_out1 = regFile[src1];
assign alu_out2 = regFile[src2]; 

always @(posedge clk) begin
    if (write_enable) begin
      //Memory data in
      if (mem_data_in) begin
        regFile[dest] <= memory_in;
      end
      else if (pc_next_enable) begin
        regFile[dest] <= pc_addr_in;
      end
      else begin
        regFile[dest] <= alu_data_in;
      end

      //regFile[dest] <= (mem_data_in) ? memory_in : alu_data_in;
    end
  //Debug register 2 and 7
  $display("R3: %h - R20: %h - R7: %h - R31: %h", regFile[3], regFile[20], regFile[7], regFile[31]);
end

endmodule
