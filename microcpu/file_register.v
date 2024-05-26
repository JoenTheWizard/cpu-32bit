module file_register(
 input clk,
 input [4:0] src1, src2, dest,
 input [31:0] alu_data_in, memory_in,

 input mem_data_in,
 input write_enable,

 output wire [31:0] alu_out1,
 output wire [31:0] alu_out2
);

reg [31:0] regFile[0:31];

//Read from file to initialize the 16 registers
initial begin
    $readmemh("readmem/file.mem", regFile);
end

assign alu_out1 = regFile[src1];
assign alu_out2 = regFile[src2]; 

always @(posedge clk) begin
    if (write_enable) begin
      regFile[dest] <= (mem_data_in) ? memory_in : alu_data_in;
    end
  //Debug register 2 and 7
  $display("Register 3: %h - Register 20: %h - Register 7: %h", regFile[3], regFile[20], regFile[7]);
end

endmodule
