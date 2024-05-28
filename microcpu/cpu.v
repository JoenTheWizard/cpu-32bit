module cpu(
  input             clk, 
  input             reset,
  input  [31:0]     instruction,
  input  [31:0]     data_mem_out,
  output [25:0]     pc_out,

  output            mem_rd,
  output            mem_wr,
  output reg [31:0] data_mem_in,
  output reg [11:0] ram_addr
);

/*
func: The function or opcode that specifies the operation to perform
src1: The first source register
src2: The second source register
dest: The destination register for the result

31                                   0
+------+------+------+------+--------+
| func | src1 | src2 | dest | unused |
+------+------+------+------+--------+
   6      5      5      5      11
*/

//Outputs from the file register
wire [31:0] reg_data1, reg_data2;

//Outputs from the ALU
wire [31:0] alu_result;
wire [7:0]  status_reg;

//Outputs from control unit
wire [3:0]  alu_op;
wire [4:0]  alu_src1, alu_src2, alu_dest;
wire [25:0] load_pc_val;
wire [31:0] imm_val;
wire load_pc, reg_write_enable, imm, mem_data_in;

//Create the program counter. This will be passed into the program memory to obtain address
counter program_counter(
    .clk(clk),
    .reset(reset),
    .load(load_pc), //Will load the counter depending on control unit
    .load_val(load_pc_val), //Load whatever value, will actually load when load_pc signal is high
    .count(pc_out)
);

//Create file register
file_register register_file(
    .clk(clk),
    .src1(alu_src1),
    .src2(alu_src2),
    .dest(alu_dest),
    .alu_data_in(alu_result), //Store the result from ALU to destination register
    .memory_in(data_mem_out),
    .mem_data_in(mem_data_in),
    .write_enable(reg_write_enable),
    .alu_out1(reg_data1),
    .alu_out2(reg_data2)
);

//Create ALU
ALU16bit alu (
    .clk(clk),
    .a(reg_data1),
    .b(reg_data2),
    .imm(imm),
    .imm_val(imm_val),
    .func(alu_op), //ALU function from instruction
    .out(alu_result),
    .status_reg(status_reg)
);

//Control Unit
control_unit ControlUnit(
    .instruction(instruction),
    .status_reg(status_reg),
    .alu_op(alu_op),
    .alu_src1(alu_src1),
    .alu_src2(alu_src2),
    .alu_dest(alu_dest),

    .imm(imm),
    .imm_val(imm_val),

    .reg_write_enable(reg_write_enable),
    
    //Branching specific output
    .load_pc(load_pc),
    .load_pc_val(load_pc_val),

    .mem_rd(mem_rd),
    .mem_wr(mem_wr),
    .mem_data_in(mem_data_in)
);

always @(*) begin
    ram_addr <= alu_result;
    data_mem_in <= reg_data2;
end

endmodule
