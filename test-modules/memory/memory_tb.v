//Define the TIME_UNIT macro
`define TIME_UNIT 5

module memory_test;

//Clock signal
reg clk;
//Address, data_in, write_enable, read_enable signals
reg [7:0] address;
reg [15:0] data_in;
reg write_enable;
reg read_enable;
//Output signal
wire [15:0] data_out;

//Instantiate the memory module
memory uut(
    .clk(clk),
    .address(address),
    .data_in(data_in),
    .write_enable(write_enable),
    .read_enable(read_enable),
    .data_out(data_out)
);

always begin
    #`TIME_UNIT clk = ~clk; //Toggle the clock every TIME_UNIT time units
end

initial begin
    $dumpfile("build/memory.vcd");  //Assume in 'build' directory
    $dumpvars(0, memory_test);

    //Initialize signals
    clk = 0;
    address = 8'b0; //start at address 0
    data_in = 16'b0;
    write_enable = 0;
    read_enable = 0;
    #`TIME_UNIT

    //Write operation
    //when the write_enable is true then the data we set from data_in is stored in that address
    write_enable = 1;
    data_in = 16'h1234;
    address = 8'b00000000;
    #(`TIME_UNIT * 2); //Wait for the operation to complete

    //Read operation
    //when the read_enable is true then the data we set from data_in is read in that address
    read_enable = 1;
    address = 8'b00000000;
    #(`TIME_UNIT * 2); //Wait for the operation to complete

    //Additional test cases
    //Write to the last address
    write_enable = 1;
    read_enable = 0;
    data_in = 16'hABCD;
    address = 8'b11111111;
    #(`TIME_UNIT * 2); //Wait for the operation to complete

    //Read from the last address
    write_enable = 0;
    read_enable = 1;
    address = 8'b11111111;
    #(`TIME_UNIT * 2); //Wait for the operation to complete

    //Read from the start address again
    write_enable = 0;
    read_enable = 1;
    address = 8'b00000000;
    #(`TIME_UNIT * 2); //Wait for the operation to complete

    //End the simulation
    $finish();
end

endmodule
