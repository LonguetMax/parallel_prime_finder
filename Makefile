#		Program Name
# Name of the final program that can be executed
PROG = prog

#		Give Outputs
# Username for the archive, used in give
USERNAME = longuetmax
# Name of the project, used in give
PROJECT_NAME = parallel_prime_finder
# Name and Path for the output folder
OUTPUT_FOLDER = $(USERNAME)-$(PROJECT_NAME)/

#		Aliases Folders
# Folder for the binaries, compiled stuff there
BIN_FOLDER = bin/
# Folder for the sourcefiles, .c and .o there
SRC_FOLDER = src/
# Folder for the documentation, so it doesn't pollute other things
DOC_FOLDER = doc/

#		Aliases Files
# Path to every .c file in the sources
SRC = $(wildcard $(SRC_FOLDER)*.c)
# Path to every .h file in the sources
HEAD = $(wildcard $(SRC_FOLDER)*.h)
# Substitution of .c for .o files during the compiling process
OBJ = $(subst $(SRC_FOLDER), $(BIN_FOLDER),$(SRC:.c=.o))
# Path to README file
README = README.md
# Path to Doxyfile
DOXYFILE = Doxyfile
# Path to Makefile
MAKEFILE = Makefile

#		Aliases Commands
# Put gcc flags here, like -Wall, -lm when compiling math.h...
FLAGS = -Wall
# Alias for the Compiler
CC = gcc
# Alias for deletion
RM = rm -f
# Alias for recursive deletion
RMR = rm -rf


#		Main compiling process
# Call of the compiling process
all : $(BIN_FOLDER)$(PROG)

# Compiling every .o to make the main program
$(BIN_FOLDER)$(PROG) : $(OBJ)
	@echo 'Compiling the whole program to $@ ...'
	@$(CC) $(FLAGS) $(OBJ) -o $(BIN_FOLDER)$(PROG)
	@echo 'Done!'
	@echo 'Use "make run" to start !'

# Compiling every sourcefiles in .o files
$(BIN_FOLDER)%.o : $(SRC_FOLDER)%.c
	@echo 'Compiling $^   into   $@'
	@$(CC) $(FLAGS) -c $^ 	-o 	$@

# Starts the program
.PHONY : run
run : all
	@echo "Found the program, starting now..."
	./$(BIN_FOLDER)$(PROG)

.PHONY : doc
doc :
	@doxygen $(DOXYFILE)

# Cleans the .o, program, and documentation
.PHONY : clean
clean :
	@echo 'Sweeping these .o things...'
	@$(RM) $(BIN_FOLDER)*.o
	@echo 'Not forgetting the program itself...'
	@$(RM) $(BIN_FOLDER)$(PROG)
	@echo 'And the documentation (who needs that anyway ?)...'
	@$(RM) -r $(DOC_FOLDER)*