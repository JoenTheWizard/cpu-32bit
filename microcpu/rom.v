module rom(
    input      [31:0] address, //Assuming 32-bit address space
    output reg [31:0] data_out
);

//Memory size of 256 words with 16-bit instruction width (2^8 available words) 
reg [31:0] mem[0:8192];

//Read from file to initialize the instructions
initial begin
   $readmemb("readmem/instructions.mem", mem);
end

always @(*) begin
    data_out <= mem[address];
end

endmodule