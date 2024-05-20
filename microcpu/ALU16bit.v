module ALU16bit(
    input [15:0] a, b, imm_val,
    input imm,
    input [3:0] func,
    output reg [15:0] out,
    output reg [7:0] status_reg
);

wire [15:0] temp;
//Bit interpretation of function instruction
localparam [3:0]
    NOP = 4'b0000,
    ADD = 4'b0001,
    SUB = 4'b0010,
    MUL = 4'b0011,
    AND = 4'b0100,
    OR  = 4'b0101;

//Bit indexes of statuses
localparam
    EQU     = 0,
    NEQU    = 1,
    BTHAN   = 2,
    BEQUAL  = 3,
    LTHAN   = 4,
    LEQUAL  = 5;

assign temp = (imm) ? imm_val : a;

always @(*) begin
    case (func)
        ADD: out <= temp + b;
        SUB: out <= temp - b;
        MUL: out <= temp * b;
        AND: out <= temp & b;
        OR:  out <= temp | b;
        NOP: out <= temp; //Set output to 'temp' for NOP
        default: out <= 16'bx; //Set output to unknown for invalid function codes
    endcase
end

always @(*) begin
    status_reg[EQU]    <= (out == 0); //Equal
    status_reg[NEQU]   <= !status_reg[EQU]; //Not Equal
    status_reg[BTHAN]  <= (temp > b); //Bigger Than
    status_reg[BEQUAL] <= (status_reg[BTHAN] | status_reg[EQU]); //Bigger Than Equal
    status_reg[LTHAN]  <= (temp < b); //Less Than
    status_reg[LEQUAL] <= (status_reg[LTHAN] | status_reg[EQU]); //Less Than Equal
    status_reg[7:6]    <= 2'b0; //Set remaining bits to 0 (might set it something else or keep it 0 idk)
end

endmodule