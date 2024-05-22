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

//Obtain the memory output data from RAM
wire [15:0] data_mem_out; 

ram data_memory(
    .address(ram_addr),    //Connect program counter output to instruction memory address
    .data_in(16'b0),       //No need to write to instruction memory
    .write_enable(mem_wr), //We are not writing
    .read_enable(mem_rd),  //We are obtaining instructions from program memory
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

    //RAM
    .ram_addr(ram_addr),

    //Program Counter
    .pc_out(program_counter),

    //Memory read and write
    .mem_rd(mem_rd),
    .mem_wr(mem_wr)
);

endmodule