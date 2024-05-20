# Verilog projects

Just some small verilog projects I made for learning. The projects use GTKWave and IVerilog.

Right now I have:
## test-modules
- NOR-based SR (Set/Reset) Latch: A sequential circuit with two cross coupled NOR gates used for memory circuits to store values
- Four-bit adder: A full adder that adds two 4 bit values
- 4x1 Multiplexer: A 4-to-1 multiplexer, a combinational circuit, that selects from one of four input signals
- ALU (4 input): A combinational circuit that utilizes the 4x1 multiplexer and performs arithmetic/bitwise operations depending on selection bits. It can input and output 16 bit values
- 4 bit counter: A counter that increments on every rising edge clock cycle, with the ability to load values

## microcpu
Very small unfinished implementation of a 16-bit CPU. So far it can do operations on registers and store it into registers, jumps and loading immediate values. As of the CPU, right now it has:

- An ALU 
- Program memory 
- Register file 
- Control unit 
- Program counter

Things to to add:

- Status register
- Data memory