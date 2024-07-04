module control_register(
    //Inputs
    input clk,
    input flush,
    input [3:0]       in_alu_op,
    input [4:0]       in_alu_src1,
    input [4:0]       in_alu_src2,
    input [4:0]       in_alu_dest,

    input             in_reg_write_enable,
    input             in_imm,
    input [31:0]      in_imm_val,

    //Branching specific output
    input             in_load_pc,
    input [31:0]      in_load_pc_val,

    //Read or write memory
    input             in_mem_rd,
    input             in_mem_wr,
    input             in_mem_data_in,

    //Program counter (for CALL/RET)
    input             in_pc_next_enable,
    input             in_alu_next_enable,
    
    //Outputs
    output reg [3:0]  out_alu_op,
    output reg [4:0]  out_alu_src1,
    output reg [4:0]  out_alu_src2,
    output reg [4:0]  out_alu_dest,

    output reg        out_reg_write_enable,
    output reg        out_imm,
    output reg [31:0] out_imm_val,

    //Branching specific output
    output reg        out_load_pc,
    output reg [31:0] out_load_pc_val,

    //Read or write memory
    output reg        out_mem_rd,
    output reg        out_mem_wr,
    output reg        out_mem_data_in,

    //Program counter (for CALL/RET)
    output reg        out_pc_next_enable,
    output reg        out_alu_next_enable
);

//** Design first, will include into CPU later **

always @(posedge clk) begin
    out_alu_op           <= flush ? 4'b0  : in_alu_op;
    out_alu_src1         <= flush ? 5'b0  : in_alu_src1;
    out_alu_src2         <= flush ? 5'b0  : in_alu_src2;
    out_alu_dest         <= flush ? 5'b0  : in_alu_dest;
    out_reg_write_enable <= flush ? 1'b0  : in_reg_write_enable;
    out_imm              <= flush ? 1'b0  : in_imm;
    out_imm_val          <= flush ? 32'b0 : in_imm_val;
    out_load_pc          <= flush ? 1'b0  : in_load_pc;
    out_load_pc_val      <= flush ? 32'b0 : in_load_pc_val;
    out_mem_rd           <= flush ? 1'b0  : in_mem_rd;
    out_mem_wr           <= flush ? 1'b0  : in_mem_wr;
    out_mem_data_in      <= flush ? 1'b0  : in_mem_data_in;
    out_pc_next_enable   <= flush ? 1'b0  : in_pc_next_enable;
    out_alu_next_enable  <= flush ? 1'b0  : in_alu_next_enable;
end


endmodule