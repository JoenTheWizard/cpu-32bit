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

- Implemention of more instructions maybe? (PUSH, POP etc)
- Interrupts
- Pipelining
- Assembler (not fully related to the CPU implementation)

Within the `readmem/` folder, it contains:

- `data.mem`: The memory set for the data memory in hex format (the RAM)
- `instructions.mem`: The memory set for the program memory in binary format (the ROM)
- `registers.mem`: The memory set for the file registers in hex format

## assembler
This will be the assembler program to output the binary file for the simulation. Right now it can output the binary string.

Usage:

`build/asm [-v] [-o filename] input_file`

- `-o filename`: Output file
- `-v`: Verbose mode

## test-modules
These are just test modules for testing and is not fully related to the CPU. I kept it though for future reference. They can be ran with `make TARGET=[folder]` where `[folder]` is the folder that contains the module and its corresponding testbench. The test modules include:

- NOR-based SR (Set/Reset) Latch: A sequential circuit with two cross coupled NOR gates used for memory circuits to store values
- Four-bit adder: A full adder that adds two 4 bit values
- 4x1 Multiplexer: A 4-to-1 multiplexer, a combinational circuit, that selects from one of four input signals
- ALU (4 input): A combinational circuit that utilizes the 4x1 multiplexer and performs arithmetic/bitwise operations depending on selection bits. It can input and output 16 bit values
- 4 bit counter: A counter that increments on every rising edge clock cycle, with the ability to load values
- Pipelining: Very basic 3-staged pipelining example to simulate how it would function
