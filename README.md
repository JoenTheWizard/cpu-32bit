# microcpu
Very small unfinished implementation of a 32-bit CPU done in Verilog. The simulation is done through GTKWave and compiled with IVerilog and can be ran with the included Makefile. As of the CPU, right now it has:

- ALU 
- Program memory 
- Register file 
- Control unit 
- Program counter
- Status register
- Data memory

Things to to add:

- Assembler (not related to the CPU)
- Interrupts
- Pipelining
- Implemention of more instructions (PUSH, POP, JR etc)

## test-modules
These are just test modules for testing and is not fully related to the CPU. I kept it though for future reference. They can be ran with `make TARGET=[folder]` where `[folder]` is the folder that contains the module and its corresponding testbench. The test modules include:

- NOR-based SR (Set/Reset) Latch: A sequential circuit with two cross coupled NOR gates used for memory circuits to store values
- Four-bit adder: A full adder that adds two 4 bit values
- 4x1 Multiplexer: A 4-to-1 multiplexer, a combinational circuit, that selects from one of four input signals
- ALU (4 input): A combinational circuit that utilizes the 4x1 multiplexer and performs arithmetic/bitwise operations depending on selection bits. It can input and output 16 bit values
- 4 bit counter: A counter that increments on every rising edge clock cycle, with the ability to load values