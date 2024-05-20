module cpu(
  input clk, 
  input reset
);

/*
func: The function or opcode that specifies the operation to perform
src1: The first source register
src2: The second source register
dest: The destination register for the result

15                          0
+------+------+------+------+
| func | src1 | src2 | dest |
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
wire [11:0] pc_out;
counter program_counter(
    .clk(clk),
    .reset(reset),
    .load(load_pc), //Will load the counter depending on control unit
    .load_val(load_pc_val), //Load whatever value, will actually load when load_pc signal is high
    .count(pc_out)
);

//Create file register
wire [15:0] reg_data1, reg_data2;
file_register register_file(
    .clk(clk),
    .src1(alu_src1),
    .src2(alu_src2),
    .dest(alu_dest),
    .data_in(alu_result), //Store the result from ALU to destination register
    .write_enable(reg_write_enable),
    .alu_out1(reg_data1),
    .alu_out2(reg_data2)
);

//Create ALU
wire [15:0] alu_result;
ALU16bit alu (
    .a(reg_data1),
    .b(reg_data2),
    .imm(imm),
    .imm_val(imm_val),
    .func(alu_op), //ALU function from instruction
    .out(alu_result)
);

//Control Unit
wire [3:0] alu_op;
wire [3:0] alu_src1, alu_src2, alu_dest;
wire load_pc, reg_write_enable, imm;
wire [11:0] load_pc_val;
wire [15:0] imm_val;
control_unit ControlUnit(
    .instruction(instruction),
    .alu_op(alu_op),
    .alu_src1(alu_src1),
    .alu_src2(alu_src2),
    .alu_dest(alu_dest),

    .imm(imm),
    .imm_val(imm_val),

    .reg_write_enable(reg_write_enable),
    //Branching specific output
    .load_pc(load_pc),
    .load_pc_val(load_pc_val)
);

endmodule
