computer: build
	iverilog ALU16bit.v file_register.v counter.v rom.v ram.v cpu.v computer.v testbenches/computer_tb.v control_unit.v -o build/computer
	vvp build/computer
	gtkwave build/computer.vcd

cpu: build
	iverilog testbenches/ALU16bit.v file_register.v counter.v ram.v cpu.v testbenches/cpu_tb.v control_unit.v -o build/cpu
	vvp build/cpu
	gtkwave build/cpu.vcd

build:
	mkdir -p build

clean:
	rm build/*
