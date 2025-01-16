# use gcc as compiler
CC=gcc
# compiler flags passed to gcc
CFLAGS=-g -m32 -O0 -fno-stack-protector -no-pie -D_FORTIFY_SOURCE=0 -z execstack

# generalize Makefile by abstracting away common dirs
SRC_DIR=src
OBJ_DIR=obj

# get list of all source files in the source dir
SRC = $(wildcard $(SRC_DIR)/*.c)
# get the names of the source files without path prefix and type suffix
TARGETS = $(patsubst $(SRC_DIR)/%.c,%,$(SRC))

# all and clean are not file but rather functions
.PHONY: all clean

# keep object files (make removes intermediate files per default)
.PRECIOUS: $(OBJ_DIR)/%.o

all: $(TARGETS)

%: $(OBJ_DIR)/%.o
	$(CC) $(CFLAGS) $< -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -r $(OBJ_DIR) $(TARGETS)
