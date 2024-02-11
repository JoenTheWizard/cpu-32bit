BUILD_DIR=build
VERG=iverilog

TARGET := sr_latch

#Run and compile program. Use TARGET variable to change directory to compile e.g.:
#make TARGET=four_bit_adder
run: $(BUILD_DIR)
	 $(VERG) $(TARGET)/*.v -o $(BUILD_DIR)/$(TARGET)
	 vvp $(BUILD_DIR)/$(TARGET)
	 gtkwave $(BUILD_DIR)/$(TARGET).vcd

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

clean:
	rm $(BUILD_DIR)/*
