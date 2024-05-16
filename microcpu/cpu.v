module cpu(
  input clk, 
  input reset
);

/*
src1: The first source register
src2: The second source register
dest: The destination register for the result
func: The function or opcode that specifies the operation to perform

15                          0
+------+------+------+------+
| src1 | src2 | dest | func |
+------+------+------+------+
   4      4      4      4
*/

//Obtain the instruction from the memory
wire [15:0] instruction;
memory program_memory(
    .clk(clk),
    .address(pc_out), //Connect program counter output to instruction memory address
    .data_in(16'b0), //No need to write to instruction memory
    .write_enable(1'b0), //We are not writing
    .read_enable(1'b1), //We are obtaining instructions from program memory
    .data_out(instruction)
);

//Create the program counter. This will be passed into the program memory to obtain address
wire [15:0] pc_out;
counter program_counter(
    .clk(clk),
    .reset(reset),
    .load(1'b0), //No need to load program counter initially
    .load_val(16'b0), //Also no need to store value address to jump to
    .count(pc_out)
);

//Create file register
wire [15:0] reg_data1, reg_data2;
file_register register_file(
    .clk(clk),
    .src1(instruction[15:12]),
    .src2(instruction[11:8]),
    .dest(instruction[7:4]),
    .data_in(alu_result), //Store the result from ALU to destination register
    .alu_out1(reg_data1),
    .alu_out2(reg_data2)
);

//Create ALU
wire [15:0] alu_result;
ALU16bit alu (
    .a(reg_data1),
    .b(reg_data2),
    .func(instruction[3:0]), //ALU function from instruction
    .out(alu_result)
);

endmodule