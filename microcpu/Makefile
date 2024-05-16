cpu:
	iverilog ALU16bit.v file_register.v counter.v memory.v cpu.v cpu_tb.v -o cpu
	./cpu
	gtkwave cpu.vcd

clean:
	rm cpu