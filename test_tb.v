module sr_latch_test;

reg S,  R;
wire Q, Q_n;

sr_latch uut(S, R, Q, Q_n);

initial begin
    $dumpfile("build/sr_latch.vcd");
    $dumpvars(0, sr_latch_test);

    S = 0; R = 0;
    #10
    S = 1; R = 0;
    #10
    S = 0; R = 0;
    #10
    S = 0; R = 1;
    #10
    S = 0; R = 0;
    #10

    //Bad case
    //S = 1; R = 1;
    $finish();
end

endmodule
