#include "search_primes.h"


int is_prime(int n)
{
    if (n < 2) {
        return 0;
    }
    for (int i = 2; i <= n / 2; i++) {
        if (n % i == 0) {
            return 0;
        }
    }
    return 1;
}


void search_primes(int lower, int upper, int rank, int return_fd)
{
    // For every number in the interval, check if it's a prime
    for (int i = lower; i <= upper; i++) {
        // If it's a prime, write the number in return_fd
        if (is_prime(i)) {
            int return_tab[2] = {rank, i};
            write(return_fd, return_tab, sizeof(return_tab));
        }
    }
    // Once the interval is checked, tell master we are free [rank, FREE]
    int return_tab[2] = {rank, FREE};
    if (DBG) printf("DBG - write  search_primes(rank=%d)\n", rank);
    write(return_fd, return_tab, sizeof(return_tab));
    if (DBG) printf("DBG - end of search_primes(rank=%d)\n", rank);
}


void worker(int rank, int read_fd, int return_fd)
{
    int interval[2];
    while (1) {
        // Read the interval from the pipe
        if (read(read_fd, interval, sizeof(interval)) < 0) {
            perror("read");
            exit(EXIT_FAILURE);
        }
        // Terminate if the interval is (0, 0)
        if (interval[0] == 0 && interval[1] == 0) {
            break;
        }
        // Process the interval using search_primes() function
        if (DBG) printf("DBG - Worker received : %d [%d, %d]\n", rank, interval[0], interval[1]);
        search_primes(interval[0], interval[1], rank, return_fd);
    }
    // Close the read end of the pipe
    close(return_fd);
    close(read_fd);
    exit(EXIT_SUCCESS);
}