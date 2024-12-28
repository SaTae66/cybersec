# directories
SRC_DIR=src
OBJ_DIR=obj

# C compiler and compilation flags
CC=gcc
CFLAGS=-g -m32 -O0 -fno-stack-protector -no-pie

# make sure SOURCES includes ALL source files required to compile the project
SOURCES=main.c
TARGET=cybersec

# derived variables
OBJECTS=$(SOURCES:%.c=$(OBJ_DIR)/%.o)
DEPS=$(SOURCES:%.c=$(DEP_DIR)/%.d)

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(DEP_DIR) $(OBJ_DIR)
	$(CC) $(CFLAGS) $(DEPFLAGS) -o $@ -c $<

$(DEP_DIR):
	@mkdir -p $(DEP_DIR)

$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

-include $(DEPS)

clean:
	rm -rf $(OBJ_DIR) $(DEP_DIR)