module file_register(
 input clk,
 input [3:0] src1, src2, dest,
 input [15:0] data_in,
 output wire [15:0] alu_out1,
 output wire [15:0] alu_out2
);

reg [15:0] regFile[15:0];

//Read from file to initialize the 16 registers
initial begin
    $readmemh("readmem/file.mem", regFile);
end

assign alu_out1 = regFile[src1];
assign alu_out2 = regFile[src2]; 

always @(posedge clk) begin
    regFile[dest] <= data_in;
end

endmodule