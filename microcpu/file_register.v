module file_register(
 input clk,
 input [3:0] src1, src2, dest,
 input [15:0] alu_data_in, memory_in,

 input mem_data_in,
 input write_enable,

 output wire [15:0] alu_out1,
 output wire [15:0] alu_out2
);

reg [15:0] regFile[0:15];

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
  //$display("Register 2: %h - Register 7: %h", regFile[2], regFile[7]);
end

endmodule
