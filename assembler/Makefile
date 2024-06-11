BUILD_DIR=build
CC=gcc
DEBUG=-g

asm: $(BUILD_DIR)
	$(CC) $(DEBUG) *.c includes/*.c -o $(BUILD_DIR)/asm

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

clean:
	rm $(BUILD_DIR)/*
