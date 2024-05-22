computer: build
	iverilog ALU16bit.v file_register.v counter.v rom.v cpu.v computer.v computer_tb.v control_unit.v -o build/computer
	vvp build/computer
	gtkwave build/computer.vcd

cpu: build
	iverilog ALU16bit.v file_register.v counter.v ram.v cpu.v cpu_tb.v control_unit.v -o build/cpu
	vvp build/cpu
	gtkwave build/cpu.vcd

build:
	mkdir -p build

clean:
	rm build/*
