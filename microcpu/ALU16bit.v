module ALU16bit(
    input [15:0] a, b,
    input [3:0] func,
    output reg [15:0] out
);

// Bit interpretation of function instruction
localparam [3:0]
    NOP = 4'b0000,
    ADD = 4'b0001,
    SUB = 4'b0010,
    MUL = 4'b0011,
    AND = 4'b0100,
    OR  = 4'b0101;

always @(*) begin
    case (func)
        ADD: out <= a + b;
        SUB: out <= a - b;
        MUL: out <= a * b;
        AND: out <= a & b;
        OR:  out <= a | b;
        NOP: out <= 16'b0; //Set output to 0 for NOP
        default: out <= 16'bx; //Set output to unknown for invalid function codes
    endcase
end

endmodule