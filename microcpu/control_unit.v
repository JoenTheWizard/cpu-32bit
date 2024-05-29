module control_unit(
    input      [31:0] instruction,
    input      [7:0]  status_reg,

    output reg [3:0]  alu_op,
    output reg [4:0]  alu_src1,
    output reg [4:0]  alu_src2,
    output reg [4:0]  alu_dest,

    output reg        reg_write_enable,
    output reg        imm,
    output reg [31:0] imm_val,

    //Branching specific output
    output reg        load_pc,
    output reg [25:0] load_pc_val,

    //Read or write memory
    output reg        mem_rd,
    output reg        mem_wr,
    output reg        mem_data_in
);

//Function operation
localparam [3:0]
    FUNC_NOP = 4'b0000,
    FUNC_ADD = 4'b0001,
    FUNC_SUB = 4'b0010,
    FUNC_MUL = 4'b0011,
    FUNC_AND = 4'b0100,
    FUNC_OR  = 4'b0101;

//Opcode
localparam [5:0]
    NOP = 6'b000000,
    ADD = 6'b000001,
    SUB = 6'b000010,
    MUL = 6'b000011,
    AND = 6'b000100,
    OR  = 6'b000101,
    JMP = 6'b000110, //Jump
    LUI = 6'b000111, //Load Upper Immediate
    LLI = 6'b001000, //Load Lower Immediate
    CMP = 6'b001010, //Compare
    JEQ = 6'b001011, //Jump If Equal
    LOD = 6'b001100, //Load From Address
    STR = 6'b001101; //Store To Address

always @(*) begin
    //Begin to check the opcode operands and perform correct operation
    case (instruction[31:26])
        NOP: begin
            //Set output to 0 for NOP
            alu_op           <= FUNC_NOP;
            alu_src1         <= 5'b0;
            alu_src2         <= 5'b0;
            alu_dest         <= 5'b0;
            load_pc          <= 1'b0;
            load_pc_val      <= 26'b0;
            reg_write_enable <= 1'b0;
            imm              <= 1'b0;
            imm_val          <= 32'b0;
            mem_wr           <= 1'b0;
            mem_rd           <= 1'b0;
            mem_data_in      <= 1'b0;
        end 
        ADD: begin
            //Set signals for the ADD instruction
            alu_op           <= FUNC_ADD;
            alu_src1         <= instruction[25:21];
            alu_src2         <= instruction[20:16];
            alu_dest         <= instruction[15:11];
            load_pc          <= 1'b0;
            load_pc_val      <= 26'b0;
            reg_write_enable <= 1'b1;
            imm              <= 1'b0;
            imm_val          <= 32'b0;
            mem_wr           <= 1'b0;
            mem_rd           <= 1'b0;
            mem_data_in      <= 1'b0;
        end 
        SUB: begin
            //Set signals for the SUB instruction
            alu_op           <= FUNC_SUB;
            alu_src1         <= instruction[25:21];
            alu_src2         <= instruction[20:16];
            alu_dest         <= instruction[15:11];
            load_pc          <= 1'b0;
            load_pc_val      <= 26'b0;
            reg_write_enable <= 1'b1;
            imm              <= 1'b0;
            imm_val          <= 32'b0;
            mem_wr           <= 1'b0;
            mem_rd           <= 1'b0;
            mem_data_in      <= 1'b0;
        end
        MUL: begin
            //Set signals for the MUL instruction
            alu_op           <= FUNC_MUL;
            alu_src1         <= instruction[25:21];
            alu_src2         <= instruction[20:16];
            alu_dest         <= instruction[15:11];
            load_pc          <= 1'b0;
            load_pc_val      <= 26'b0;
            reg_write_enable <= 1'b1;
            imm              <= 1'b0;
            imm_val          <= 32'b0;
            mem_wr           <= 1'b0;
            mem_rd           <= 1'b0;
            mem_data_in      <= 1'b0;
        end 
        AND: begin
            //Set signals for the AND instruction
            alu_op           <= FUNC_AND;
            alu_src1         <= instruction[25:21];
            alu_src2         <= instruction[20:16];
            alu_dest         <= instruction[15:11];
            load_pc          <= 1'b0;
            load_pc_val      <= 26'b0;
            reg_write_enable <= 1'b1;
            imm              <= 1'b0;
            imm_val          <= 32'b0;
            mem_wr           <= 1'b0;
            mem_rd           <= 1'b0;
            mem_data_in      <= 1'b0;
        end 
        OR: begin
            //Set signals for the OR instruction
            alu_op           <= FUNC_OR;
            alu_src1         <= instruction[25:21];
            alu_src2         <= instruction[20:16];
            alu_dest         <= instruction[15:11];
            load_pc          <= 1'b0;
            load_pc_val      <= 26'b0;
            reg_write_enable <= 1'b1;
            imm              <= 1'b0;
            imm_val          <= 32'b0;
            mem_wr           <= 1'b0;
            mem_rd           <= 1'b0;
            mem_data_in      <= 1'b0;
        end
        JMP: begin
            //Set signals for the JMP instruction
            alu_op           <= FUNC_NOP; //Set to NOP since no operation is being done in JMP
            alu_src1         <= 5'b0;
            alu_src2         <= 5'b0;
            alu_dest         <= 5'b0;
            load_pc          <= 1'b1;
            load_pc_val      <= instruction[25:0];
            reg_write_enable <= 1'b0;
            imm              <= 1'b0;
            imm_val          <= 32'b0;
            mem_wr           <= 1'b0;
            mem_rd           <= 1'b0;
            mem_data_in      <= 1'b0;
        end
        LUI: begin
            //Set signals for the LUI instruction
            alu_op           <= FUNC_NOP;
            alu_src1         <= 5'b0;
            alu_src2         <= 5'b0;
            alu_dest         <= instruction[25:21];
            load_pc          <= 1'b0;
            load_pc_val      <= 26'b0;
            reg_write_enable <= 1'b1;
            imm              <= 1'b1;
            imm_val          <= {instruction[15:0], 16'b0};
            mem_wr           <= 1'b0;
            mem_rd           <= 1'b0;
            mem_data_in      <= 1'b0;
        end
        LLI: begin
            //Set signals for the LLI instruction
            alu_op           <= FUNC_OR;
            alu_src1         <= 5'b0;
            alu_src2         <= instruction[25:21];
            alu_dest         <= instruction[25:21];
            load_pc          <= 1'b0;
            load_pc_val      <= 26'b0;
            reg_write_enable <= 1'b1;
            imm              <= 1'b1;
            imm_val          <= {16'b0, instruction[15:0]};
            mem_wr           <= 1'b0;
            mem_rd           <= 1'b0;
            mem_data_in      <= 1'b0;
        end
        CMP: begin
            //Set signals for the CMP instruction
            alu_op           <= FUNC_SUB; //Compare by subtracting
            alu_src1         <= instruction[25:21];
            alu_src2         <= instruction[20:16];
            alu_dest         <= 5'b0;
            load_pc          <= 1'b0;
            load_pc_val      <= 26'b0;
            reg_write_enable <= 1'b0;
            imm              <= 1'b0;
            imm_val          <= 32'b0;
            mem_wr           <= 1'b0;
            mem_rd           <= 1'b0;
            mem_data_in      <= 1'b0;
        end
        JEQ: begin
            //Set signals for the JEQ instruction
            alu_op           <= FUNC_NOP; //No ALU operation
            alu_src1         <= 5'b0;
            alu_src2         <= 5'b0;
            alu_dest         <= 5'b0;
            load_pc          <= status_reg[0]; //Jump if equ flag is set
            load_pc_val      <= instruction[25:0];
            reg_write_enable <= 1'b0;
            imm              <= 1'b0;
            imm_val          <= 32'b0;
            mem_wr           <= 1'b0;
            mem_rd           <= 1'b0;
            mem_data_in      <= 1'b0;
        end
        LOD: begin 
            //Set signals for the LOD instruction
            alu_op           <= FUNC_NOP; //No ALU operation
            alu_src1         <= instruction[20:16];
            alu_src2         <= 5'b0;
            alu_dest         <= instruction[25:21];
            load_pc          <= 1'b0;
            load_pc_val      <= 26'b0;
            reg_write_enable <= 1'b1;
            imm              <= 1'b0;
            imm_val          <= 32'b0;
            mem_wr           <= 1'b0;
            mem_rd           <= 1'b1;
            mem_data_in      <= 1'b1;
        end
        STR: begin
            //Set signals for the STR instruction
            alu_op           <= FUNC_NOP; //No ALU operation
            alu_src1         <= instruction[20:16];
            alu_src2         <= instruction[25:21];
            alu_dest         <= 5'b0;
            load_pc          <= 1'b0;
            load_pc_val      <= 26'b0;
            reg_write_enable <= 1'b0;
            imm              <= 1'b0;
            imm_val          <= 32'b0;
            mem_wr           <= 1'b1;
            mem_rd           <= 1'b0;
            mem_data_in      <= 1'b0;
        end
    endcase
end

endmodule
