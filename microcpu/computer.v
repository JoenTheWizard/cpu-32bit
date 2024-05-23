module computer(
    input clk,
    input reset
);

//Obtain the instruction from the program memory
wire [15:0] instruction;

//Obtain the program counter from the CPU
wire [11:0] program_counter;

//Obtain the memory access of RAM from CPU
wire [11:0] ram_addr;

//Obtain RAM read or write
wire mem_rd, mem_wr;

//Obtain the memory output and input data from RAM
wire [15:0] data_mem_out;
wire [15:0] data_mem_in;

ram data_memory(
    .clk(clk),
    .address(ram_addr),    //Connect program counter output to instruction memory address
    .data_in(data_mem_in), //Write to data memory
    .write_enable(mem_wr), //Write signal
    .read_enable(mem_rd),  //Read signal
    .data_out(data_mem_out)
);

rom program_memory(
    .address(program_counter), //Assuming 8-bit address space
    .data_out(instruction)
);

cpu processor(
    .clk(clk),
    .reset(reset),

    //Obtain instruction
    .instruction(instruction),

    .data_mem_out(data_mem_out),
    .data_mem_in(data_mem_in),

    //RAM
    .ram_addr(ram_addr),

    //Program Counter
    .pc_out(program_counter),

    //Memory read and write
    .mem_rd(mem_rd),
    .mem_wr(mem_wr)
);

endmodule