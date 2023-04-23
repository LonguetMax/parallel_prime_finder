#		Program Name
# Name of the final program that can be executed
PROG = prog

#		Give Outputs
# Username for the archive, used in give
USERNAME = longuetmax
# Name of the project, used in give
PROJECT_NAME = parallel_prime_numbers_finder
# Name and Path for the output folder
OUTPUT_FOLDER = $(USERNAME)-$(PROJECT_NAME)/

#		Aliases Folders
# Folder for the binaries, compiled stuff there
BIN_FOLDER = bin/
# Folder for the sourcefiles, .c and .o there
SRC_FOLDER = src/
# Backup folder, copy of sourcefiles, README, Doxyfile and Makefile there
BACKUP_FOLDER = save/
# Folder for the documentation, so it doesn't pollute other things
DOC_FOLDER = doc/

#		Aliases Files
# Path to every .c file in the sources
SRC = $(wildcard $(SRC_FOLDER)*.c)
# Path to every .h file in the sources
HEAD = $(wildcard $(SRC_FOLDER)*.h)
# Substitution of .c for .o files during the compiling process
OBJ = $(subst $(SRC_FOLDER), $(BIN_FOLDER),$(SRC:.c=.o))
# Name of the README file, should be in root of the project
README = README.md
# Name of the Doxyfile, should be in root of the project
DOXYFILE = Doxyfile
# Name of the Makefile, should be in root of the project
MAKEFILE = Makefile

#		Aliases Commands
# Put gcc flags here, like -Wall, -lm when compiling math.h...
FLAGS = -Wall -lm
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
run :
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

# Safer backup process (forces the backup, doesn't wipe the backup folder)
.PHONY : save
save :
	@echo 'Saving the sourcefiles...'
	@cp -f $(SRC) $(BACKUP_FOLDER)
	@echo 'Saving the headers...'
	@cp -f $(HEAD) $(BACKUP_FOLDER)
	@echo 'Saving the $(README)...'
	@cp -f $(README) $(BACKUP_FOLDER)
	@echo 'Saving the $(DOXYFILE)...'
	@cp -f $(DOXYFILE) $(BACKUP_FOLDER)
	@echo 'Saving the $(MAKEFILE)...'
	@cp -f $(MAKEFILE) $(BACKUP_FOLDER)

# Rougher backup process (wipes the backup folder before making a fresh one)
.PHONY : savePurge
savePurge :
	@echo 'Getting rid of the backup folder...'
	@$(RMR) $(BACKUP_FOLDER)
	@echo 'Creating a fresh one...'
	@mkdir $(BACKUP_FOLDER)
	@echo 'Saving the sourcefiles...'
	@cp -f $(SRC) $(BACKUP_FOLDER)
	@echo 'Saving the headers...'
	@cp -f $(HEAD) $(BACKUP_FOLDER)
	@echo 'Saving the $(README)...'
	@cp -f $(README) $(BACKUP_FOLDER)
	@echo 'Saving the $(DOXYFILE)...'
	@cp -f $(DOXYFILE) $(BACKUP_FOLDER)
	@echo 'Saving the $(MAKEFILE)...'
	@cp -f $(MAKEFILE) $(BACKUP_FOLDER)

# Safer restore process (forces the restore, doesn't wipe the sources folder)
.PHONY : restore
restore : $(BACKUP_FOLDER)
	@echo 'Restoring the sourcefiles...'
	@cp -f $(BACKUP_FOLDER)*.c $(SRC_FOLDER)
	@echo 'Restoring the headers...'
	@cp -f $(BACKUP_FOLDER)*.h $(SRC_FOLDER)
	@echo 'Restoring that $(README)...'
	@cp -f $(BACKUP_FOLDER)$(README) ./
	@echo 'Restoring that $(DOXYFILE)...'
	@cp -f $(BACKUP_FOLDER)$(DOXYFILE) ./
	@echo 'Restoring that $(MAKEFILE)...'
	@cp -f $(BACKUP_FOLDER)$(MAKEFILE) ./

# Rougher restore process (wipes the sources folder before making a fresh one)
.PHONY : restorePurge
restorePurge : $(BACKUP_FOLDER)
	@echo 'Getting rid of the $(SRC_FOLDER) folder...'
	@$(RMR) $(SRC_FOLDER)
	@echo 'Creating a fresh one...'
	@mkdir $(SRC_FOLDER)
	@echo 'Restoring the sourcefiles...'
	@cp -f $(BACKUP_FOLDER)*.c $(SRC_FOLDER)
	@echo 'Restoring the headers...'
	@cp -f $(BACKUP_FOLDER)*.h $(SRC_FOLDER)
	@echo 'Restoring that $(README)...'
	@cp -f $(BACKUP_FOLDER)$(README) ./
	@echo 'Restoring that $(DOXYFILE)...'
	@cp -f $(BACKUP_FOLDER)$(DOXYFILE) ./
	@echo 'Restoring that $(MAKEFILE)...'
	@cp -f $(BACKUP_FOLDER)$(MAKEFILE) ./

# Prepares the archive, gets everything ready to be turned in as long as it can be compiled
.PHONY : give
#	Making sure we can compile before preparing the archiveS
give : all
	@echo 'Sorry, had to make sure this thing can be compiled.'
	@echo 'Sweeping the output folder...'
	@$(RMR) $(OUTPUT_FOLDER)
# 		Creates the subfolders and copies what needs to be
#			Binaries
	@echo 'Creating a fresh $(OUTPUT_FOLDER)$(BIN_FOLDER)...'
	@mkdir -p $(OUTPUT_FOLDER)$(BIN_FOLDER)
#			Backup
	@echo 'Creating a fresh $(OUTPUT_FOLDER)$(BACKUP_FOLDER)...'
	@mkdir -p $(OUTPUT_FOLDER)$(BACKUP_FOLDER)
#			Sourcefiles
	@echo 'Creating a fresh $(OUTPUT_FOLDER)$(SRC_FOLDER)...'
	@mkdir -p $(OUTPUT_FOLDER)$(SRC_FOLDER)
	@echo 'Coyping the sourcefiles there...'
	@cp -rf $(SRC_FOLDER)* $(OUTPUT_FOLDER)$(SRC_FOLDER)
#			Documentation
	@echo 'Creating a fresh $(OUTPUT_FOLDER)$(DOC_FOLDER)...'
	@mkdir -p $(OUTPUT_FOLDER)$(DOC_FOLDER)
#			README, Doxyfile, Makefile
	@echo 'Copying the $(README)...'
	@cp -f $(README) $(OUTPUT_FOLDER)
	@echo 'Copying the $(DOXYFILE)...'
	@cp -f $(DOXYFILE) $(OUTPUT_FOLDER)
	@echo 'Copying the $(MAKEFILE)...'
	@cp -f $(MAKEFILE) $(OUTPUT_FOLDER)
#		Archiving
	@echo 'Creating the archive of that folder...'
	@tar -czf $(USERNAME)-$(PROJECT_NAME).tgz $(OUTPUT_FOLDER)
	@echo 'Done!'
	@echo 'It should appear as $(USERNAME)-$(PROJECT_NAME).tgz !'