module ram # (
    parameter ADDR_WIDTH = 14, //Number of addressing bits (must be less than 'address' bit length)
    parameter DATA_WIDTH = 32  //Width of data bits
) (
   input                            clk,

   input [31:0]                     address, //Assuming 32-bit address space
   input [DATA_WIDTH-1:0]           data_in,

   input                            write_enable,
   input                            read_enable,

   output reg [DATA_WIDTH-1:0]      data_out
);

//Memory size of 16384 words with 32-bit instruction width (2^14 available dwords)
reg [DATA_WIDTH-1:0] mem[0:(2**ADDR_WIDTH-1)];

//Read from file to initialize the instructions
initial begin
   $readmemh("readmem/data.mem", mem);
end

always @(*) begin
   //On read
   if (read_enable) begin
      data_out <= mem[address[ADDR_WIDTH-1:0]];
   end
end

always @(posedge clk) begin
   //On write
   if (write_enable) begin
      mem[address[ADDR_WIDTH-1:0]] <= data_in;
   end
end

endmodule