module ALU16bit(
    input clk,
    input [31:0] a, b, imm_val,
    input imm,
    input [3:0] func,
    output reg [31:0] out,
    output reg [7:0] status_reg
);

//Store operand (depending on immediate signal)
wire [31:0] temp;

//Hold next state of status register
reg [7:0] status_reg_next;

localparam [3:0]
    NOP  = 4'b0000,
    ADD  = 4'b0001,
    SUB  = 4'b0010,
    MUL  = 4'b0011,
    AND  = 4'b0100,
    OR   = 4'b0101,
    XOR  = 4'b0110,
    XNOR = 4'b0111,
    SHL  = 4'b1000,
    SHR  = 4'b1001,
    INC  = 4'b1010,
    DEC  = 4'b1011;

//Bit indexes of statuses
localparam
    EQU    = 0,
    NEQU   = 1,
    BTHAN  = 2,
    BEQUAL = 3,
    LTHAN  = 4,
    LEQUAL = 5;

assign temp = (imm) ? imm_val : a;

always @(*) begin
    case (func)
        NOP:  out <= temp; //Set output to 'temp' for NOP
        ADD:  out <= temp + b;
        SUB:  out <= temp - b;
        MUL:  out <= temp * b;
        AND:  out <= temp & b;
        OR:   out <= temp | b;
        XOR:  out <= temp ^ b;
        XNOR: out <= ~(temp ^ b);
        SHL:  out <= temp << b;
        SHR:  out <= temp >> b;
        INC:  out <= temp + 1;
        DEC:  out <= temp - 1;
        default: out <= 16'bx; //Set output to unknown for invalid function codes
    endcase
end

always @(*) begin
    status_reg_next[EQU]    <= (out == 0); //Equal
    status_reg_next[NEQU]   <= !status_reg_next[EQU]; //Not Equal
    status_reg_next[BTHAN]  <= (temp > b); //Bigger Than
    status_reg_next[BEQUAL] <= (status_reg_next[BTHAN] | status_reg_next[EQU]); //Bigger Than Equal
    status_reg_next[LTHAN]  <= (temp < b); //Less Than
    status_reg_next[LEQUAL] <= (status_reg_next[LTHAN] | status_reg_next[EQU]); //Less Than Equal
    status_reg_next[7:6]    <= 2'b0; //Set remaining bits to 0 (might set it something else or keep it 0 idk)
end

//Latch the status_reg on the positive edge of clock
always @(posedge clk) begin
    status_reg <= status_reg_next;
end

endmodule
