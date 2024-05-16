module memory(
 input clk,
 input [15:0] address, //Assuming 8-bit address space
 input [15:0] data_in,
 input write_enable, input read_enable,
 output reg [15:0] data_out
);

//Memory size of 256 words with 16-bit instruction width (2^8 available words) 
reg [15:0] mem[255:0];

//Read from file to initialize the instructions
initial begin
   $readmemb("readmem/instructions.mem", mem);
end

always @(posedge clk) begin
 //On write
 if (write_enable) begin
    mem[address] <= data_in;
 end
 //On read
 if (read_enable) begin
    data_out <= mem[address];
 end
end

endmodule