# Parallel Prime Finder
## Context
This has been done as a school project. The objective is to find the prime numbers in a set interval, but using multiple processes that will communicate through **pipes**.

For it to work, the master-process creates a **pool of worker-processes**, a list of sub-intervals from the initial one. When a worker is free (doing nothing), he gets a small interval to check, and returns the found prime-numbers to the master.

## Sources Structure
The program is compiled from multiple source files :
- `search_primes.h` contains a set of functions for the workers, and constants to play around with 'debug prints', the number of workers, etc.
- `utils.h` contains a set of more generic functions, basic utilitaries like min / max, sorting algorithm, etc.
- `main.c` contains the general flow of the program, most of it is the master process.


## Using the Makefile

The Makefile will help you compile and run the program, as well as deleting some binaries.
You can do so with the following instructions.

### Compile :
    $ make
        Handles compiling, linking and assembling the sources in a final executable file.

### Run :
    $ make run
        Executes the program. If it is not found or not up to date, it will be compile first.

### Clean :
    $ make clean
        Deletes all binaries and documentation.
