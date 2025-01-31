# Makefile for building inlineExecute-Assembly BOF in both x86 and x64 with cl.exe

# Directories
SRC_DIR     = src
INCLUDE_DIR = include
OBJ_DIR     = obj

# Source file (same for both builds)
SRC_FILE    = inlineExecute-Assembly.c

# Output object names
OBJ_X64     = $(OBJ_DIR)/inlineExecute-Assemblyx64.o
OBJ_X86     = $(OBJ_DIR)/inlineExecute-Assemblyx86.o

# Compiler commands for x64 and x86.
# - In the x64 Native Tools prompt, CC_64 = cl produces 64-bit objects.
# - In the x86 Native Tools prompt, CC_32 = cl produces 32-bit objects.
CC_64       = cl
CC_32       = cl

# Common compiler flags. (cl.exe ignores many GCC flags.)
# /c     = compile only, no link
# /GS-   = disable security checks
## NOT IN USE 
# /O2    = optimize
# /nologo = hide the "Microsoft C/C++..." banner
# /Zl    = omit default library name in .obj
CFLAGS_COMMON = /c /GS-

# Include path (/I <dir>)
INCLUDES = /I$(INCLUDE_DIR)

.PHONY: all clean

# 'make all' builds both x64 and x86
all: $(OBJ_X64) 
#$(OBJ_X86)

# ======== 64-bit build rule ========
# This rule compiles inlineExecute-Assembly.c with cl.exe,
# outputs an object file named inlineExecute-Assemblyx64.o
$(OBJ_X64): $(SRC_DIR)/$(SRC_FILE)
	@mkdir -p $(OBJ_DIR)
	$(CC_64) $(CFLAGS_COMMON) $(INCLUDES) /Fo$@ $<

# ======== 32-bit build rule ========
# Similarly, for x86.  If you want to produce x86 from the
# same prompt, you'll need a cross compiler or the x64_x86
# cross tools environment.
#$(OBJ_X86): $(SRC_DIR)/$(SRC_FILE)
#	@mkdir -p $(OBJ_DIR)
#	$(CC_32) $(CFLAGS_COMMON) $(INCLUDES) /Fo$@ $<

clean:
	rm -rf $(OBJ_DIR)
