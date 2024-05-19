module ALU16bit(
    input [15:0] a, b, imm_val,
    input imm,
    input [3:0] func,
    output reg [15:0] out
);

wire [15:0] temp;
// Bit interpretation of function instruction
localparam [3:0]
    NOP = 4'b0000,
    ADD = 4'b0001,
    SUB = 4'b0010,
    MUL = 4'b0011,
    AND = 4'b0100,
    OR  = 4'b0101;

assign temp = (imm) ? imm_val : a;

always @(*) begin
    case (func)
        ADD: out <= temp + b;
        SUB: out <= temp - b;
        MUL: out <= temp * b;
        AND: out <= temp & b;
        OR:  out <= temp | b;
        NOP: out <= temp; //Set output to 0 for NOP
        default: out <= 16'bx; //Set output to unknown for invalid function codes
    endcase
end

endmodule