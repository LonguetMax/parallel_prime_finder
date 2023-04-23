#ifndef __UTILS_H__
#define __UTILS_H__


/**
 * Returns the maximum of two integers.
 *
 * @author LonguetMax
 * @param a The first integer.
 * @param b The second integer.
 *
 * @return The maximum of the two integers.
 */
int max(int a, int b);

/**
 * Returns the minimum of two integers.
 *
 * @author LonguetMax
 * @param a The first integer.
 * @param b The second integer.
 *
 * @return The minimum of the two integers.
 */
int min(int a, int b);

/**
 * Divides an interval into N sub-intervals.
 *
 * @author LonguetMax
 * @param start     The start of the interval.
 * @param end       The end of the interval.
 * @param N         The number of sub-intervals to create.
 * @param subints   An array to store the sub-intervals.
 */
void divideInterval(int start, int end, int N, int subints[][2]);

/**
 * Swaps the values of two integers.
 *
 * @author Code_r (@GeekForGeeks.org)
 * @param xp Pointer to the first integer.
 * @param yp Pointer to the second integer.
 */
void swap(int* xp, int* yp);
  
/**
 * Sorts an array of integers using the Selection Sort algorithm.
 *
 * @author Code_r (@GeekForGeeks.org)
 * @param arr The array to sort.
 * @param n   The size of the array.
 */
void selectionSort(int arr[], int n);




#endif