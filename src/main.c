#include "search_primes.h"
#include "utils.h"
#include <sys/wait.h>
#include <fcntl.h>

int main() {
    int rank = 0;

    /* CREATING PIPES */
    int return_fd[2];
    int worker_pipes[NUM_WORKERS][2];
    // Create the return pipe
    if (pipe(return_fd) < 0) { perror("pipe"); exit(1); }
    // Set read end of return_fd pipe to non-blocking mode
    int flags = fcntl(return_fd[0], F_GETFL, 0);
    fcntl(return_fd[0], F_SETFL, flags | O_NONBLOCK);
    // Create worker pipes
    for (int i = 0; i < NUM_WORKERS; i++) {
        if (pipe(worker_pipes[i]) < 0) {
            perror("pipe");
            exit(1);
        }
    }

    /* CREATING WORKERS */
    int workers[NUM_WORKERS][2];
    for (int i = 0; i < NUM_WORKERS; i++) {
        int pid = fork();
        // Error
        if (pid == -1) { exit(1); }
        // Master
        else if (pid > 0) { workers[i][PID] = pid; workers[i][STATUS] = FREE; }
        // Workers
        else {
            rank = i+1;
            worker(rank, worker_pipes[i][0], return_fd[1]); // TODO : Check le fd de retour
            //worker(rank, worker_pipes[i][0], worker_pipes[i][1]); // TODO : Check le fd de retour
            exit(1);
        }
    }
    
    /* ---------- MASTER ---------- */
    /* CREATING SUB-INTERVALS */
    int N = NUM_WORKERS * SPLITS_PW;
    int subints[N][2];
    divideInterval(INTERVAL_START, INTERVAL_END, N, subints);


    /* SEARCHING PRIME NUMBERS */
    // Preparing the execution
    int n = 0;
    int searched_subints = 0;
    int max_size = INTERVAL_END - INTERVAL_START;
    int prime_numbers[max_size];
    for (int i = 0; i < max_size; i++) {
        prime_numbers[i] = 0;
    }
    
    // Spread tasks to every free worker in the pool
    int still_busy = 0;
    while(searched_subints < N || still_busy) {
        // Find the first free worker
        for (int i = 0; i < NUM_WORKERS; i++) {
            if (searched_subints < N && workers[i][STATUS] == FREE) {
                workers[i][STATUS] = BUSY;
                // And assign a sub-interval
                if (DBG) printf("DBG - assigned to %d\n", i+1);
                int order_tab[2] = {subints[searched_subints][0], subints[searched_subints][1]};
                write(worker_pipes[i][1], order_tab, sizeof(order_tab));
                searched_subints++;
                break;
                // Once a task is assigned, leave the for loop
            }
        }

        // Get data from return_fd
        int returned_val[2];
        while (read(return_fd[0], returned_val, sizeof(returned_val)) > 0 && n < max_size) {
            // If the returned value is 'FREE' (0), the worker is freed,
            if (returned_val[1] == FREE) {
                workers[returned_val[0]-1][STATUS] = FREE;
            }
            // Else it is a prime number
            else {
                prime_numbers[n] = returned_val[1];
                n++;
            }
        }
        
        // Check if any worker is still looking for primes
        still_busy = 0;
        for (int i = 0; i < NUM_WORKERS; i++)
            still_busy += workers[i][STATUS];
    }

    
    // Tell every worker their job is done and wait for them to die
    for (int i = 0; i < NUM_WORKERS; i++) {
        int order_tab[2] = {0, 0};
        write(worker_pipes[i][1], order_tab, sizeof(order_tab));
        wait(NULL);
    }
    

    // Now sort and print the prime numbers found
    selectionSort(prime_numbers, n);
    if (DBG) printf("\n\n");
    printf("%d prime numbers found in [%d:%d] :\n", n, INTERVAL_START, INTERVAL_END);
    for (int i = 0; i < n; i++) {
        printf("\t%d,\n", prime_numbers[i]);
    }

    return 0;
}