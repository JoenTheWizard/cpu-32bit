module ram(
   input clk,
   input [11:0] address, //Assuming 8-bit address space
   input [31:0] data_in,

   input        write_enable,
   input        read_enable,

   output reg [31:0] data_out
);

//Memory size of 256 words with 16-bit instruction width (2^8 available words) 
reg [31:0] mem[0:2047];

//Read from file to initialize the instructions
initial begin
   $readmemh("readmem/data.mem", mem);
end

always @(*) begin
   //On read
   if (read_enable) begin
      data_out <= mem[address];
   end
end

always @(posedge clk) begin
   //On write
   if (write_enable) begin
      mem[address] <= data_in;
   end
   //$display("Mem 1: %h",  mem[1]);
end

endmodule