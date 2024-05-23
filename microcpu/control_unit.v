module control_unit(
    input      [15:0] instruction,
    input      [7:0]  status_reg,

    output reg [3:0]  alu_op,
    output reg [3:0]  alu_src1,
    output reg [3:0]  alu_src2,
    output reg [3:0]  alu_dest,

    output reg        reg_write_enable,
    output reg        imm,
    output reg [15:0] imm_val,

    //Branching specific output
    output reg        load_pc,
    output reg [11:0] load_pc_val,

    //Read or write memory
    output reg        mem_rd,
    output reg        mem_wr,
    output reg        mem_data_in
);

localparam [3:0]
    NOP = 4'b0000,
    ADD = 4'b0001,
    SUB = 4'b0010,
    MUL = 4'b0011,
    AND = 4'b0100,
    OR  = 4'b0101,
    JMP = 4'b0110, //Jump
    LUI = 4'b0111, //Load Upper Immediate
    LLI = 4'b1000, //Load Lower Immediate
    CMP = 4'b1010, //Compare
    JEQ = 4'b1011, //Jump If Equal
    LOD = 4'b1100, //Load From Address
    STR = 4'b1101; //Store To Address

always @(*) begin
    //Begin to check the opcode operands and perform correct operation
    case (instruction[15:12])
        NOP: begin
            //Set output to 0 for NOP
            alu_op           <= 4'b0;
            alu_src1         <= 4'b0;
            alu_src2         <= 4'b0;
            alu_dest         <= 4'b0;
            load_pc          <= 1'b0;
            load_pc_val      <= 12'b0;
            reg_write_enable <= 1'b0;
            imm              <= 1'b0;
            imm_val          <= 16'b0;
            mem_wr           <= 1'b0;
            mem_rd           <= 1'b0;
            mem_data_in      <= 1'b0;
        end 
        ADD: begin
            //Set signals for the ADD instruction
            alu_op           <= ADD;
            alu_src1         <= instruction[11:8];
            alu_src2         <= instruction[7:4];
            alu_dest         <= instruction[3:0];
            load_pc          <= 1'b0;
            load_pc_val      <= 12'b0;
            reg_write_enable <= 1'b1;
            imm              <= 1'b0;
            imm_val          <= 16'b0;
            mem_wr           <= 1'b0;
            mem_rd           <= 1'b0;
            mem_data_in      <= 1'b0;
        end 
        SUB: begin
            //Set signals for the SUB instruction
            alu_op           <= SUB;
            alu_src1         <= instruction[11:8];
            alu_src2         <= instruction[7:4];
            alu_dest         <= instruction[3:0];
            load_pc          <= 1'b0;
            load_pc_val      <= 12'b0;
            reg_write_enable <= 1'b1;
            imm              <= 1'b0;
            imm_val          <= 16'b0;
            mem_wr           <= 1'b0;
            mem_rd           <= 1'b0;
            mem_data_in      <= 1'b0;
        end
        MUL: begin
            //Set signals for the MUL instruction
            alu_op           <= MUL;
            alu_src1         <= instruction[11:8];
            alu_src2         <= instruction[7:4];
            alu_dest         <= instruction[3:0];
            load_pc          <= 1'b0;
            load_pc_val      <= 12'b0;
            reg_write_enable <= 1'b1;
            imm              <= 1'b0;
            imm_val          <= 16'b0;
            mem_wr           <= 1'b0;
            mem_rd           <= 1'b0;
            mem_data_in      <= 1'b0;
        end 
        AND: begin
            //Set signals for the AND instruction
            alu_op           <= AND;
            alu_src1         <= instruction[11:8];
            alu_src2         <= instruction[7:4];
            alu_dest         <= instruction[3:0];
            load_pc          <= 1'b0;
            load_pc_val      <= 12'b0;
            reg_write_enable <= 1'b1;
            imm              <= 1'b0;
            imm_val          <= 16'b0;
            mem_wr           <= 1'b0;
            mem_rd           <= 1'b0;
            mem_data_in      <= 1'b0;
        end 
        OR: begin
            //Set signals for the OR instruction
            alu_op           <= OR;
            alu_src1         <= instruction[11:8];
            alu_src2         <= instruction[7:4];
            alu_dest         <= instruction[3:0];
            load_pc          <= 1'b0;
            load_pc_val      <= 12'b0;
            reg_write_enable <= 1'b1;
            imm              <= 1'b0;
            imm_val          <= 16'b0;
            mem_wr           <= 1'b0;
            mem_rd           <= 1'b0;
            mem_data_in      <= 1'b0;
        end
        JMP: begin
            //Set signals for the JMP instruction
            alu_op           <= NOP; //Set to NOP since no operation is being done in JMP
            alu_src1         <= 4'b0;
            alu_src2         <= 4'b0;
            alu_dest         <= 4'b0;
            load_pc          <= 1'b1;
            load_pc_val      <= instruction[11:0];
            reg_write_enable <= 1'b0;
            imm              <= 1'b0;
            imm_val          <= 16'b0;
            mem_wr           <= 1'b0;
            mem_rd           <= 1'b0;
            mem_data_in      <= 1'b0;
        end
        LUI: begin
            //Set signals for the LUI instruction
            alu_op           <= 4'b0;
            alu_src1         <= 4'b0;
            alu_src2         <= 4'b0;
            alu_dest         <= instruction[11:8];
            load_pc          <= 1'b0;
            load_pc_val      <= 12'b0;
            reg_write_enable <= 1'b1;
            imm              <= 1'b1;
            imm_val          <= {instruction[7:0], 8'b0};
            mem_wr           <= 1'b0;
            mem_rd           <= 1'b0;
            mem_data_in      <= 1'b0;
        end
        LLI: begin
            //Set signals for the LLI instruction
            alu_op           <= OR;
            alu_src1         <= 4'b0;
            alu_src2         <= instruction[11:8];
            alu_dest         <= instruction[11:8];
            load_pc          <= 1'b0;
            load_pc_val      <= 12'b0;
            reg_write_enable <= 1'b1;
            imm              <= 1'b1;
            imm_val          <= {8'b0, instruction[7:0]};
            mem_wr           <= 1'b0;
            mem_rd           <= 1'b0;
            mem_data_in      <= 1'b0;
        end
        CMP: begin
            //Set signals for the CMP instruction
            alu_op           <= SUB; //Compare by subtracting
            alu_src1         <= instruction[11:8];
            alu_src2         <= instruction[7:4];
            alu_dest         <= 4'b0;
            load_pc          <= 1'b0;
            load_pc_val      <= 12'b0;
            reg_write_enable <= 1'b0;
            imm              <= 1'b0;
            imm_val          <= 16'b0;
            mem_wr           <= 1'b0;
            mem_rd           <= 1'b0;
            mem_data_in      <= 1'b0;
        end
        JEQ: begin
            //Set signals for the JEQ instruction
            alu_op           <= NOP; //No ALU operation
            alu_src1         <= 4'b0;
            alu_src2         <= 4'b0;
            alu_dest         <= 4'b0;
            load_pc          <= status_reg[0]; //Jump if equ flag is set
            load_pc_val      <= instruction[11:0];
            reg_write_enable <= 1'b0;
            imm              <= 1'b0;
            imm_val          <= 16'b0;
            mem_wr           <= 1'b0;
            mem_rd           <= 1'b0;
            mem_data_in      <= 1'b0;
        end
        LOD: begin 
            //Set signals for the LOD instruction
            alu_op           <= NOP; //No ALU operation
            alu_src1         <= instruction[7:4];
            alu_src2         <= 4'b0;
            alu_dest         <= instruction[11:8];
            load_pc          <= 4'b0;
            load_pc_val      <= 12'b0;
            reg_write_enable <= 1'b1;
            imm              <= 1'b0;
            imm_val          <= 16'b0;
            mem_wr           <= 1'b0;
            mem_rd           <= 1'b1;
            mem_data_in      <= 1'b1;
        end
        STR: begin
            //Set signals for the STR instruction
            alu_op           <= NOP; //No ALU operation
            alu_src1         <= instruction[7:4];
            alu_src2         <= instruction[11:8];
            alu_dest         <= 4'b0;
            load_pc          <= 4'b0;
            load_pc_val      <= 12'b0;
            reg_write_enable <= 1'b0;
            imm              <= 1'b0;
            imm_val          <= 16'b0;
            mem_wr           <= 1'b1;
            mem_rd           <= 1'b0;
            mem_data_in      <= 1'b0;
        end
    endcase
end

endmodule
