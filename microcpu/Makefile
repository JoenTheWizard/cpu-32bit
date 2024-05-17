cpu: build
	iverilog ALU16bit.v file_register.v counter.v memory.v cpu.v cpu_tb.v -o build/cpu
	vvp build/cpu
	gtkwave build/cpu.vcd

build:
	mkdir -p build

clean:
	rm build/*
