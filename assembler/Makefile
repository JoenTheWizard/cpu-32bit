CC=gcc

BUILD_DIR=build


#Check if DEBUG is set
ifeq ($(DEBUG),1)
	DEBUG_FLAGS=-g -fsanitize=undefined -Wall -Wextra -pedantic
endif

asm: $(BUILD_DIR)
	$(CC) $(DEBUG_FLAGS) *.c includes/*.c -o $(BUILD_DIR)/asm

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

clean:
	rm $(BUILD_DIR)/*
