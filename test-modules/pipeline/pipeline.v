module pipeline (
    input wire clk,
    input wire flush,
    input wire [7:0] a,
    input wire [7:0] b,
    output reg [8:0] result
);

    //The pipeline registers
    reg [7:0] stage1_a, stage1_b;
    reg [8:0] stage2_sum;

    //Stage 1: Input Registration
    always @(posedge clk or posedge flush) begin
        if (flush) begin
            stage1_a <= 8'b0;
            stage1_b <= 8'b0;
        end else begin
            stage1_a <= a;
            stage1_b <= b;
        end
    end

    //Stage 2: Addition
    always @(posedge clk or posedge flush) begin
        if (flush) begin
            stage2_sum <= 9'b0;
        end else begin
            stage2_sum <= stage1_a + stage1_b;
        end
    end

    //Stage 3: Output Registration
    always @(posedge clk or posedge flush) begin
        if (flush) begin
            result <= 9'b0;
        end else begin
            result <= stage2_sum;
        end
    end
endmodule

