BUILD_DIR=build
CC=gcc

asm: $(BUILD_DIR)
	$(CC) *.c -o $(BUILD_DIR)/asm

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

clean:
	rm $(BUILD_DIR)/*
