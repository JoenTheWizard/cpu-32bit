module rom(
    input      [31:0] address, //Assuming 32-bit address space
    output reg [31:0] data_out
);

//Memory size of 8192 words with 32-bit instruction width (2^13 available dwords) 
reg [31:0] mem[0:8191];

//Read from file to initialize the instructions
initial begin
   $readmemb("readmem/instructions.mem", mem);
end

always @(*) begin
    data_out <= mem[address];
end

endmodule