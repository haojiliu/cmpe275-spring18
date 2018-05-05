#include "header.h"

/*
 * Compare two matrices. Return 0 if they are the same, 1 otherwise.
 */
int compare_matrix(const uint64_t* sample, const uint64_t* reference) {
	for (int i = 0; i < WIDTH2*HEIGHT2; i++) {
		if (sample[i] != reference[i]) {
			return 1;
		}
	}
	return 0;
}
