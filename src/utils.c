#include "utils.h"

int max(int a, int b) {
    if (a > b) { return a; }
    return b;
}
int min(int a, int b) {
    if (a < b) { return a; }
    return b;
}

void divideInterval(int start, int end, int N, int subints[][2])
{
    int size = end - start + 1;
    int step = size / N;
    int remainder = size % N;
    int i;
    int upper_bound = start + step - 1;
    for (i = 0; i < N; i++) {
        subints[i][0] = start;
        subints[i][1] = upper_bound;
        start = upper_bound + 1;
        if (i < remainder) {
            upper_bound = start + step;
        } else {
            upper_bound = start + step - 1;
        }
    }
}


void swap(int* xp, int* yp) {
    int temp = *xp;
    *xp = *yp;
    *yp = temp;
}
  
void selectionSort(int arr[], int n) {
    int i, j, min_idx;

    // One by one move boundary of unsorted subarray
    for (i = 0; i < n - 1; i++) {
        // Find the minimum element in unsorted array
        min_idx = i;
        for (j = i + 1; j < n; j++)
            if (arr[j] < arr[min_idx])
                min_idx = j;
        // Swap the found minimum element
        // with the first element
        swap(&arr[min_idx], &arr[i]);
    }
}
