BUILD_DIR=build
VERG=iverilog
OUT=$(BUILD_DIR)/sr_latch

all: compile run

compile:
	$(VERG) *.v -o $(OUT)

run:
	vvp $(OUT)

gtkwave:
	gtkwave $(OUT).vcd


clean:
	rm build/*
