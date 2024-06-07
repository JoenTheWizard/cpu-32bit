module rom # (
    parameter ADDR_WIDTH = 13, //No. of addressing bits (must be less than 'address' bit length)
    parameter DATA_WIDTH = 32  //Width of data bits
) (
    input      [31:0]           address, //Assuming 32-bit address space
    output reg [DATA_WIDTH-1:0] data_out
);

//Memory size of 8192 words with 32-bit instruction width (2^13 available dwords) 
reg [DATA_WIDTH-1:0] mem[0:(2**ADDR_WIDTH-1)];

//Read from file to initialize the instructions
initial begin
    $readmemb("readmem/instructions.mem", mem);
end

always @(*) begin
    //Address length will be the masked bits specified by the ADDR_WIDTH
    data_out <= mem[address[ADDR_WIDTH-1:0]];
end

endmodule