#ifndef __SEARCH_PRIMES__
#define __SEARCH_PRIMES__

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define DBG 0       // Set to 1 to show some debugging messages, 0 to hide them
#define NUM_WORKERS 4   // Number of workers in the pool
#define SPLITS_PW 8     // Number of sub-intervals PER WORKER
#define INTERVAL_START 1    // Start of the interval
#define INTERVAL_END 1000   // End of the interval
#define PID 0       // Tab index for PID
#define STATUS 1    // Tab index for STATUS
#define BUSY 1      // Tab value for busy worker
#define FREE 0      // Tab value for free worker


/**
 * Searches for prime numbers in a given interval and writes them to a file descriptor.
 * 
 * @author LonguetMax
 * @param lower The lower bound of the interval.
 * @param upper The upper bound of the interval.
 * @param rank The rank of the worker process.
 * @param return_fd The file descriptor to write the prime numbers to.
 */
int is_prime(int n);

/**
 * Searches for prime numbers in a given interval and writes them to a file descriptor.
 *
 * @author LonguetMax
 * @param lower     The lower bound of the interval.
 * @param upper     The upper bound of the interval.
 * @param rank      The rank of the worker process.
 * @param return_fd The file descriptor to write the prime numbers to.
 */
void search_primes(int lower, int upper, int rank, int return_fd);

/**
 * Searches for prime numbers in a given interval and writes them to a file descriptor.
 * 
 * @author LonguetMax
 * @param rank      The rank of the worker process.
 * @param read_fd   The file descriptor to read the intervals from.
 * @param return_fd  The file descriptor to write the prime numbers to.
 */
void worker(int rank, int read_fd, int return_fd);

#endif