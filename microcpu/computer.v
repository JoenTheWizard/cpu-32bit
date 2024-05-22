module computer(
    input clk,
    input reset
);

//Obtain the instruction from the program memory
wire [15:0] instruction;

//Obtain the program counter from the processor
wire [11:0] program_counter;

// ram data_memory(
//     .clk(clk),
//     .address(pc_out),    //Connect program counter output to instruction memory address
//     .data_in(16'b0),     //No need to write to instruction memory
//     .write_enable(1'b0), //We are not writing
//     .read_enable(1'b1),  //We are obtaining instructions from program memory
//     .data_out(instruction)
// );

rom program_memory(
    .address(program_counter), //Assuming 8-bit address space
    .data_out(instruction)
);

cpu processor(
    .clk(clk),
    .reset(reset),
    .instruction(instruction),
    .pc_out(program_counter)
);

endmodule